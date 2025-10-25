import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectflow_web/domain/models/member_model.dart';
import 'package:projectflow_web/presentation/features/projects/bloc/project_bloc.dart';
import 'package:projectflow_web/presentation/features/projects/views/widgets/member/member_listile.dart';
import 'package:projectflow_web/presentation/sharedwidgets/custom_button.dart';
import 'package:projectflow_web/presentation/theme/colors.dart';
import 'package:projectflow_web/presentation/theme/styles.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MembersSection extends StatefulWidget {
  const MembersSection({super.key, this.onInviteTap});
  final VoidCallback? onInviteTap;

  @override
  State<MembersSection> createState() => _MembersSectionState();
}

class _MembersSectionState extends State<MembersSection> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<ProjectBloc>().add(GetMembersEvent());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Project Members",
                  style: sataoshiBold.copyWith(fontSize: 18),
                ),
                SizedBox(
                  width: 170,
                  child: CustomButton(
                    trailing: const Icon(Icons.add, color: Colors.white),
                    buttonColor: AppColors.primary500,
                    onPressed: widget.onInviteTap!,
                    text: "Invite Member",
                    textStyle: sataoshiMedium.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            Expanded(
              child: BlocBuilder<ProjectBloc, ProjectState>(
                buildWhen: (previous, current) =>
                    current is GetMemberLoading ||
                    current is GetMemberSuccess ||
                    current is GetMemberFailure,
                builder: (context, state) {
                  log(state.toString()) ;
                  if (state is GetMemberLoading) {
                    return _buildMembersList([], isLoading: true);
                  }

                  if (state is GetMemberSuccess) {
                    final members = state.members;
                    if (members.isEmpty) {
                      return Center(
                        child: Text(
                          "No members found.",
                          style: sataoshiMedium.copyWith(
                            color: Colors.grey[600],
                            fontSize: 15,
                          ),
                        ),
                      );
                    }
                    return _buildMembersList(members, isLoading: false);
                  }

                  if (state is GetMemberFailure) {
                    return Center(
                      child: Text(
                        "Failed to load members. Try again later.",
                        style: sataoshiMedium.copyWith(
                          color: Colors.red,
                          fontSize: 15,
                        ),
                      ),
                    );
                  }

                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMembersList(List<MemberModel> members,
      {required bool isLoading}) {

    return Skeletonizer(
      enabled: isLoading,
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: isLoading ? 5 : members.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          if(!isLoading) {
            final member = members[index];
            return MemberListTile(
              isLoading: false,
              name: member.user!.fullName!,
              joinedAt: member.joinedAt!,
              role: member.role!,
              imageUrl: member.user!.imageUrl!,
              onTap: () {},
            );
          }
          return MemberListTile(
            isLoading: true,
            name: "" ,
            joinedAt: "" ,
            role: "",
            imageUrl: "",
            onTap: () {},
          );
        },
      ),
    );
  }
}
