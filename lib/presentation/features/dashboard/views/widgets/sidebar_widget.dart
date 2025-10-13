import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'package:collapsible_sidebar/collapsible_sidebar/collapsible_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:projectflow_web/core/dependencyInjection/dependency_injector.dart';
import 'package:projectflow_web/core/helpers/extensions/screen_config_extension.dart';
import 'package:projectflow_web/generated/assets.dart';
import 'package:projectflow_web/presentation/features/dashboard/bloc/navigation_bloc.dart';
import 'package:projectflow_web/presentation/features/dashboard/views/screens/dashboard_screen.dart';
import 'package:projectflow_web/presentation/features/projects/views/screens/projects_screen.dart';
import 'package:projectflow_web/presentation/theme/colors.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  Widget getCurrentScreen(int index) {
    switch (index) {
      case 0:
        return const DashboardScreen();
      case 1:
        return const ProjectsScreen() ;
      case 2:
        return const Center(child: Text("⚙️ Settings Screen"));
      default:
        return const Center(child: Text("Page Not Found"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<NavigationBloc>(),
      child: Scaffold(
        body: Row(
          children: [
            BlocBuilder<NavigationBloc, NavigationState>(
              builder: (context, state) {
                final bloc = context.read<NavigationBloc>();
                List<CollapsibleItem> items = [
                  CollapsibleItem(
                    isSelected: bloc.state is ItemSelectedState &&
                        (bloc.state as ItemSelectedState).selectedIndex == 0,
                    text: 'Home',
                    icon: Icons.home,
                    onPressed: () => bloc.add(const NavigationItemSelected(0)),
                  ),
                  CollapsibleItem(
                    isSelected: bloc.state is ItemSelectedState &&
                        (bloc.state as ItemSelectedState).selectedIndex == 1,
                    text: 'Profile',
                    icon: Icons.person,
                    onPressed: () => bloc.add(const NavigationItemSelected(1)),
                  ),
                  CollapsibleItem(
                    isSelected: bloc.state is ItemSelectedState &&
                        (bloc.state as ItemSelectedState).selectedIndex == 2,
                    text: 'Settings',
                    icon: Icons.settings,
                    onPressed: () => bloc.add(const NavigationItemSelected(2)),
                  ),
                ];
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 50.h),
                  child: CollapsibleSidebar(
                    //   avatarImg: Image.asset(Assets.iconsAlert),
                    isCollapsed: MediaQuery.of(context).size.width <= 800,
                    items: items,
                    title: 'Project Flow',
                    body: Center(
                      child: ConstrainedBox(
                        constraints:  BoxConstraints(maxWidth: MediaQuery.of(context).size.width -100),
                        child: getCurrentScreen(
                          state is ItemSelectedState ? state.selectedIndex : 0,
                        ),
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
