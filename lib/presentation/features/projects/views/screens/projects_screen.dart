import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectflow_web/core/dependencyInjection/dependency_injector.dart';
import 'package:projectflow_web/core/helpers/extensions/screen_config_extension.dart';
import 'package:projectflow_web/domain/models/project_model.dart';
import 'package:projectflow_web/presentation/features/projects/bloc/project_bloc.dart';
import 'package:projectflow_web/presentation/features/projects/views/widgets/project_card.dart';
import 'package:projectflow_web/presentation/features/projects/views/widgets/project_header.dart';
import 'package:projectflow_web/presentation/utils/responsive.dart';
final List<ProjectModel> projects = [
  const ProjectModel(id: 1, title: "ProjectFlow Web", description: "Web management dashboard", progress: 0.65),
  const ProjectModel(id: 2, title: "Mobile App", description: "Flutter app for tracking", progress: 0.3),
  const ProjectModel(id: 3, title: "API Service", description: "Spring Boot backend", progress: 0.8),
  const ProjectModel(id: 4, title: "UI Redesign", description: "Modern interface revamp", progress: 0.45),
  const ProjectModel(id: 5, title: "Testing & QA", description: "Integration + unit testing", progress: 0.9),
];

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<ProjectBloc>() ,
      child: Scaffold(
          body: Padding(
            padding: EdgeInsets.only(
              left: MediaQuery
                  .of(context)
                  .size
                  .width <= 800 ? 40.w : 200.w,
              right: 40.w,
              //   top: 40.h,
              bottom: 40.h,
            ),
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ProjectHeader(),
                const SizedBox(height: 30),
                Expanded(
                  child: Responsive(
                    mobile: _buildGrid(projects, crossAxisCount: 1),
                    tablet: _buildGrid(projects, crossAxisCount: 2),
                    web: _buildGrid(projects, crossAxisCount: 4),
                  ),
                ),

              ],
            ),
          )),
    );
  }
  Widget _buildGrid(List<ProjectModel> projects, {required int crossAxisCount}) {
    return GridView.builder(
      itemCount: projects.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: 1.4,
      ),
      itemBuilder: (context, index) => ProjectCard(project: projects[index]),
    );
  }
}

