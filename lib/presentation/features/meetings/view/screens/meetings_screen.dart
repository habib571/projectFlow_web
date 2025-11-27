import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_pagination/number_pagination.dart';
import 'package:projectflow_web/domain/models/meeting.dart';
import 'package:projectflow_web/presentation/features/meetings/view/widgets/meeting_card.dart';
import 'package:projectflow_web/presentation/features/meetings/view/widgets/meetings_header.dart';
import 'package:projectflow_web/presentation/theme/colors.dart';
import 'package:projectflow_web/datasource/requests/pagination_request.dart';

import '../../meetingbloc/meeting_bloc.dart';

class MeetingsScreen extends StatefulWidget {
  const MeetingsScreen({super.key});

  @override
  State<MeetingsScreen> createState() => _MeetingsScreenState();
}

class _MeetingsScreenState extends State<MeetingsScreen> {
  late final MeetingBloc meetingBloc ;
  @override
  void initState() {
    super.initState() ;
    meetingBloc = context.read<MeetingBloc>() ;
    meetingBloc.add(GetMeetingsEvent(PaginationRequest(0, 4)));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const MeetingsHeader(),
          const SizedBox(height: 20),
          Expanded(
            child: BlocBuilder<MeetingBloc, MeetingState>(
              buildWhen: (previous, current) =>
              current is GetMeetingsLoading ||
                  current is GetMeetingsSuccess ||
                  current is GetMeetingsFailure,
              builder: (context, state) {
                final bloc = context.read<MeetingBloc>();
                log(state.toString());

                if (state is GetMeetingsLoading) {
                  return _buildMeetingList(List.generate(6, (_) => Meeting()), true);
                }

                if (state is GetMeetingsSuccess) {
                  final meetings = state.response.data;
                  final totalPages = state.response.pagination.totalPages;
                  final currentPage = state.response.pagination.currentPage;

                  return Column(
                    children: [
                      Expanded(child: _buildMeetingList(meetings, false)),
                      const SizedBox(height: 30),
                      NumberPagination(
                        buttonRadius: 180,
                        selectedButtonColor: AppColors.primary500,
                        totalPages: totalPages,
                        currentPage: currentPage + 1,
                        onPageChanged: (page) {
                          bloc.add(GetMeetingsEvent(PaginationRequest(page - 1, 4)));
                        },
                      ),
                    ],
                  );
                }

                if (state is GetMeetingsFailure) {
                  return Center(child: Text("Error: ${state.failure.message}"));
                }

                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMeetingList(List<Meeting> meetings, bool isLoading) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: meetings.length,
      itemBuilder: (context, index) {
        final meeting = meetings[index];
        return MeetingCard(
          meeting: meeting,
          isLoading: isLoading,
          onTap: () {
          },
        );
      },
    );
  }
}
