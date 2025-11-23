import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:projectflow_web/core/dependencyInjection/dependency_injector.dart';
import 'package:projectflow_web/core/helpers/extensions/screen_config_extension.dart';
import 'package:projectflow_web/generated/assets.dart';
import 'package:projectflow_web/presentation/features/dashboard/bloc/navigation_bloc.dart';
import 'package:projectflow_web/presentation/features/meetings/bloc/meeting_bloc.dart';
import 'package:projectflow_web/presentation/features/projects/bloc/project_bloc.dart';
import 'package:projectflow_web/presentation/features/tasks/bloc/task_bloc.dart';
import 'package:projectflow_web/presentation/sharedwidgets/image_placeholder.dart';
import 'package:projectflow_web/presentation/theme/colors.dart';
import 'package:projectflow_web/presentation/theme/styles.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<NavigationBloc>()),
        BlocProvider(create: (_) => getIt<ProjectBloc>()),
        BlocProvider(create: (_) => getIt<TaskBloc>()),
        BlocProvider(create: (_) => getIt<MeetingBloc>()),
      ],
      child: Scaffold(
        body: BlocBuilder<NavigationBloc, NavigationState>(
          buildWhen: (previous, current) => current is ItemSelectedState,
          builder: (context, state) {
            final bloc = context.read<NavigationBloc>();
            final selectedIndex = bloc.state is ItemSelectedState
                ? (bloc.state as ItemSelectedState).selectedIndex
                : 0;

            return Row(
              children: [
                Container(
                  width: 250.w,
                  color: Colors.white,
                  child: Padding(
                    padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    child: Column(
                      children: [
                        // Logo
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppColors.primary500,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: SvgPicture.asset(
                                Assets.imagesLogo,
                                color: Colors.white,
                                height: 24,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'ProjectFlow',
                              style: sataoshiBold.copyWith(fontSize: 20),
                            ),
                          ],
                        ),
                        const SizedBox(height: 50),

                        // Sidebar items
                        Expanded(
                          child: ListView(
                            children: [
                              _buildNavItem(
                                context,
                                icon: Icons.dashboard_outlined,
                                selectedIcon: Icons.dashboard,
                                label: "Dashboard",
                                index: 0,
                                selectedIndex: selectedIndex,
                                onTap: () {
                                  bloc.add(const NavigationItemSelected(0));
                                  context.go('/dashboard');
                                },
                              ),
                              _buildNavItem(
                                context,
                                icon: Icons.folder_outlined,
                                selectedIcon: Icons.folder,
                                label: "Projects",
                                index: 1,
                                selectedIndex: selectedIndex,
                                onTap: () {
                                  bloc.add(const NavigationItemSelected(1));
                                  context.go('/projects');
                                },
                              ),
                              _buildNavItem(
                                context,
                                icon: Icons.check_circle_outline,
                                selectedIcon: Icons.check_circle,
                                label: "Tasks",
                                index: 2,
                                selectedIndex: selectedIndex,
                                onTap: () {
                                  bloc.add(const NavigationItemSelected(2));
                                  context.go('/tasks');
                                },
                              ),
                              _buildNavItem(
                                context,
                                icon: Icons.people_outline,
                                selectedIcon: Icons.people,
                                label: "Team",
                                index: 3,
                                selectedIndex: selectedIndex,
                                onTap: () {
                                  bloc.add(const NavigationItemSelected(3));
                                  context.go('/team');
                                },
                              ),
                              _buildNavItem(
                                context,
                                icon: Icons.settings_outlined,
                                selectedIcon: Icons.settings,
                                label: "Settings",
                                index: 4,
                                selectedIndex: selectedIndex,
                                onTap: () {
                                  bloc.add(const NavigationItemSelected(4));
                                  context.go('/settings');
                                },
                              ),
                            ],
                          ),
                        ),

                        // Footer (User info)
                        const Divider(),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                           ImagePlaceHolderWeb(radius: 18, fullName: "H") ,
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Alex Turner",
                                    style: sataoshiMedium.copyWith(
                                      fontSize: 14,
                                      color: AppColors.primary500,
                                    ),
                                  ),
                                  Text(
                                    "alex@projectflow.com",
                                    style: sataoshiRegular.copyWith(
                                      fontSize: 12,
                                      color: AppColors.primaryGrey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(Icons.logout,
                                size: 18, color: AppColors.primaryGrey),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: const Color(0xffFAFAFA),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width - 100,
                        ),
                        child: child,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildNavItem(
      BuildContext context, {
        required IconData icon,
        required IconData selectedIcon,
        required String label,
        required int index,
        required int selectedIndex,
        required VoidCallback onTap,
      }) {
    final bool isSelected = index == selectedIndex;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary300.withOpacity(0.2) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
          child: Row(
            children: [
              Icon(
                isSelected ? selectedIcon : icon,
                color: isSelected
                    ? AppColors.primary500
                    : AppColors.primaryTxt,
                size: 22,
              ),
              const SizedBox(width: 10),
              Text(
                label,
                style: sataoshiMedium.copyWith(
                  fontSize: 15,
                  color: isSelected
                      ? AppColors.primary500
                      : AppColors.primaryTxt
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
