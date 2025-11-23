import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectflow_web/core/helpers/extensions/screen_config_extension.dart';
import 'package:projectflow_web/core/routes/member_tab_router.dart';
import 'package:projectflow_web/presentation/features/meetings/view/screens/meetings_screen.dart';
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
    _tabController = TabController(length: 4, vsync: this);
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
          left: 40.w,
          right: 40.w,
          top: 40.h,
          bottom: 40.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Project Header
            ProjectDetailsHeader(
              isManager: true,
              title: "Project Name",
              onDelete: () {},
              onEdit: () {},
            ),
            SizedBox(height: 24.h),

            /// Modern Tab Bar
            TabBar(
              controller: _tabController,
              isScrollable: true,
              indicatorColor: AppColors.primary500,
              indicatorWeight: 3,
              labelColor:AppColors.primary500,
              unselectedLabelColor: Colors.grey.shade600,
              labelStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              overlayColor: WidgetStateProperty.all(Colors.transparent),
              tabs: const [
                Tab(text: 'Overview'),
                Tab(text: 'Members'),
                Tab(text: 'Tasks'),
                Tab(text: 'Meetings'),
              ],
            ),

            /// Small divider below tabs
            Divider(height: 1, color: Colors.grey.shade300),

            /// Tab Content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  Builder(
                    builder: (context) {
                      return ProjectOverview(
                        project: context.read<ProjectBloc>().projectModel!,
                      );
                    },
                  ),
                  const MembersTabRouter(),
                  TasksScreen(
                    onInviteTap: () {
                      showCreateTaskDialog(
                        context,
                        context.read<ProjectBloc>().members!,
                      );
                    },
                  ),
                  const MeetingsScreen()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
