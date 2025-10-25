import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectflow_web/core/helpers/extensions/screen_config_extension.dart';
import 'package:projectflow_web/presentation/features/projects/bloc/project_bloc.dart';
import 'package:projectflow_web/presentation/sharedwidgets/image_placeholder.dart';
import 'package:projectflow_web/presentation/sharedwidgets/input_text.dart';

class SearchMemberSection extends StatefulWidget {
  final Function() onUserTap ;
  const SearchMemberSection({super.key, required this.onUserTap});

  @override
  State<SearchMemberSection> createState() => _SearchMemberSectionState();
}

class _SearchMemberSectionState extends State<SearchMemberSection> {
  final TextEditingController searchController = TextEditingController();
  Timer? _debounce;

  static const _debounceDuration = Duration(milliseconds: 7000);

  @override
  void dispose() {
    _debounce?.cancel();
    searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(_debounceDuration, () {
      final query = value.trim();
      if (query.isNotEmpty) {
        context.read<ProjectBloc>().add(SearchUserEvent(query));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 300.w, vertical: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InputText(
            controller: searchController,
            hintText: "Search Members",
            prefixIcon: const Icon(Icons.search_outlined),
            onChanged: (value) {
              if (value.trim().isNotEmpty) {
                _onSearchChanged(value);
              }
            },
          ),
          const SizedBox(height: 16),

          BlocBuilder<ProjectBloc, ProjectState>(
            builder: (context, state) {
              if (state is SearchUserLoading) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              if (state is SearchUserFailure) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Failed to load members: ${state.failure.message}",
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              }

              if (state is SearchUserSuccess) {
                final members =
                    state.response.data; // assuming data is a List<UserModel>
                if (members.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("No members found."),
                  );
                }

                return ListView.separated(
                  shrinkWrap: true,
                  itemCount: members.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final member = members[index];
                    return ListTile(
                      leading: ImagePlaceHolderWeb(
                          radius: 20, fullName: member.fullName!),
                      title: Text(member.fullName ?? "Unnamed"),
                      subtitle: Text(member.email ?? ""),
                      trailing: const Icon(Icons.add_circle_outline),
                      onTap: () {
                        context.read<ProjectBloc>().setUser(member);
                        widget.onUserTap();
                        // You can handle invite or selection here
                      },
                    );
                  },
                );
              }

              return const SizedBox(); // Default idle state
            },
          ),
        ],
      ),
    );
  }
}
