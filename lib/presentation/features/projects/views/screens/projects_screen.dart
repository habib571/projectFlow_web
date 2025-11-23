import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:number_pagination/number_pagination.dart';
import 'package:projectflow_web/core/helpers/extensions/screen_config_extension.dart';
import 'package:projectflow_web/datasource/requests/pagination_request.dart';
import 'package:projectflow_web/domain/models/project_model.dart';
import 'package:projectflow_web/presentation/features/projects/bloc/project_bloc.dart';
import 'package:projectflow_web/presentation/features/projects/views/widgets/project/project_card.dart';
import 'package:projectflow_web/presentation/features/projects/views/widgets/project/project_header.dart';
import 'package:projectflow_web/presentation/theme/colors.dart';
import 'package:projectflow_web/presentation/utils/responsive.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  int currentPage = 0;
  late final ProjectBloc _projectBloc;

  @override
  void initState() {
    super.initState();
    _projectBloc = context.read<ProjectBloc>();
    _projectBloc.add(GetProjectsEvent(PaginationRequest(currentPage, 4)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          left: 40.w,
          right: 40.w,
          top: 40.h,
          bottom: 40.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ProjectHeader(),
            const SizedBox(height: 30),
            Expanded(
              child: BlocBuilder<ProjectBloc, ProjectState>(
                buildWhen: (previous, current) =>
                current is GetProjectsLoading || current is GetProjectsSuccess || current is GetProjectsFailure,
                builder: (context, state) {
                  final bloc = context.read<ProjectBloc>();
                  log(state.toString());

                  if (state is GetProjectsLoading) {
                    return Responsive(
                      mobile: _buildGrid([], true, crossAxisCount: 1),
                      tablet: _buildGrid([], true, crossAxisCount: 2),
                      web: _buildGrid([], true, crossAxisCount: 4),
                    );
                  }

                  if (state is GetProjectsSuccess) {
                    final projects = state.response.data;
                    final totalPages = state.response.pagination.totalPages;
                    currentPage = state.response.pagination.currentPage;

                    return Column(
                      children: [
                        Expanded(
                          child: Responsive(
                            mobile: _buildGrid(projects, false, crossAxisCount: 1),
                            tablet: _buildGrid(projects, false, crossAxisCount: 2),
                            web: _buildGrid(projects, false, crossAxisCount: 4),
                          ),
                        ),
                        const SizedBox(height: 30),
                        NumberPagination(
                          buttonRadius: 180,
                          selectedButtonColor: AppColors.primary500,

                          totalPages: totalPages,
                          currentPage: currentPage + 1,
                          onPageChanged: (page) {
                            bloc.add(GetProjectsEvent(PaginationRequest(page - 1, 4)));
                          },
                        ),
                      ],
                    );
                  }

                  if (state is GetProjectsFailure) {
                    return Center(child: Text("Error: ${state.failure.message}"));
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

  Widget _buildGrid(List<ProjectModel> projects, bool isLoading,
      {required int crossAxisCount}) {
    // show skeleton placeholders while loading
    final itemCount = isLoading ? 6 : projects.length;

    return GridView.builder(
      itemCount: itemCount,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: 1.4,
      ),
      itemBuilder: (context, index) {
        final project = isLoading
            ? const ProjectModel(title: "Loading", description: "Loading...", progress: 0)
            : projects[index];

        return ProjectCard(project: project, isLoading: isLoading ,onDetailsTap: (){
          context.read<ProjectBloc>().setProjectModel(project);
          // context.read<ProjectBloc>().members!.clear() ;
          context.go('/projects/details');

        } ,onBoardTap: (){},) ;
      },
    );
  }
}
