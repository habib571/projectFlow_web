import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectflow_web/core/helpers/extensions/screen_config_extension.dart';
import 'package:projectflow_web/core/routes/member_tab_router.dart';
import 'package:projectflow_web/presentation/features/projects/bloc/project_bloc.dart';
import 'package:projectflow_web/presentation/features/projects/views/widgets/project/project_details_header.dart';
import 'package:projectflow_web/presentation/features/projects/views/widgets/project/project_overview.dart';
import 'package:projectflow_web/presentation/features/tasks/views/screens/tasks_screen.dart';
import 'package:projectflow_web/presentation/features/tasks/views/widgets/new_task_dialog.dart';
import 'package:projectflow_web/presentation/theme/colors.dart';

class ProjectDetailScreen extends StatefulWidget {
  const ProjectDetailScreen({super.key});

  @override
  State<ProjectDetailScreen> createState() => _ProjectDetailScreenState();
}

class _ProjectDetailScreenState extends State<ProjectDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    context.read<ProjectBloc>().add(GetMembersEvent());
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      body: Padding(
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width <= 800 ? 40.w : 250.w,
          right: 40.w,
          //    bottom: 40.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProjectDetailsHeader(
              isManager: true,
              title: "Project Name",
              onDelete: () {},
              onEdit: () {},
            ),
            SizedBox(height: 20.h),
            Container(
              width: 400,
              color: const Color(0xFFF7F8FA),
              child: Align(
                alignment: Alignment.topLeft,
                child: TabBar(
                  controller: _tabController,
                  labelPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  indicator: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade300, width: 0.5),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(6),
                      topRight: Radius.circular(6),
                    ),
                  ),
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.blue,
                  indicatorColor: Colors.transparent,
                  tabs: const [
                    Tab(
                        child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Text('Overview'),
                    )),
                    Tab(
                        child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Text('Members'),
                    )),
                    Tab(
                        child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Text('Tasks'),
                    )),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  Builder(builder: (context) {
                    return ProjectOverview(
                        project: context.read<ProjectBloc>().projectModel!);
                  }),
                  const MembersTabRouter(),
                  TasksScreen(
                    onInviteTap: () {
                      showCreateTaskDialog(context , context.read<ProjectBloc>().members!);
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
