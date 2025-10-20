import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:projectflow_web/core/dependencyInjection/dependency_injector.dart';
import 'package:projectflow_web/core/helpers/extensions/screen_config_extension.dart';
import 'package:projectflow_web/core/routes/app_routes.dart';
import 'package:projectflow_web/presentation/features/dashboard/bloc/navigation_bloc.dart';
import 'package:projectflow_web/presentation/features/dashboard/views/screens/dashboard_screen.dart';
import 'package:projectflow_web/presentation/features/projects/bloc/project_bloc.dart';
import 'package:projectflow_web/presentation/features/projects/views/screens/projects_screen.dart';
import 'package:projectflow_web/presentation/theme/colors.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NavigationBloc>(
          create: (context) => getIt<NavigationBloc>(),
        ),
        BlocProvider<ProjectBloc>(
          create: (context) => getIt<ProjectBloc>(),
        ),
      ],
      child: Scaffold(
        body: Row(
          children: [
            BlocBuilder<NavigationBloc, NavigationState>(
              buildWhen: (previous, current) => current is ItemSelectedState,
              builder: (context, state) {
                final bloc = context.read<NavigationBloc>();
                List<CollapsibleItem> items = [
                  CollapsibleItem(
                    isSelected: bloc.state is ItemSelectedState &&
                        (bloc.state as ItemSelectedState).selectedIndex == 0,
                    text: 'Home',
                    icon: Icons.home,
                    onPressed: () => context.go('/dashboard')
                  ),
                  CollapsibleItem(
                    isSelected: bloc.state is ItemSelectedState &&
                        (bloc.state as ItemSelectedState).selectedIndex == 1,
                    text: 'Profile',
                    icon: Icons.person,
                      onPressed: () => context.go('/projects')

                  ),
                  CollapsibleItem(
                    isSelected: bloc.state is ItemSelectedState &&
                        (bloc.state as ItemSelectedState).selectedIndex == 2,
                    text: 'Settings',
                    icon: Icons.settings,
                      onPressed: () => context.go('/settings')

                  ),
                ];
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 50.h),
                  child: CollapsibleSidebar(
                    showToggleButton: false,
                    collapseOnBodyTap: false,
                    //   avatarImg: Image.asset(Assets.iconsAlert),
                    isCollapsed: MediaQuery.of(context).size.width <= 800,
                    items: items,
                    title: 'Project Flow',
                    body: Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width - 100),
                        child: child
                      ),
                    ),

                    backgroundColor: AppColors.scaffold,
                    titleStyle:
                        const TextStyle(color: Colors.white, fontSize: 20),
                    toggleTitle: 'Menu',
                    sidebarBoxShadow: const [
                      BoxShadow(color: AppColors.primaryGrey, blurRadius: 10)
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
