import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projectflow_web/core/cache/local_storage.dart';
import 'package:projectflow_web/core/dependencyInjection/dependency_injector.dart';
import 'package:projectflow_web/presentation/features/auth/views/screens/login_screen.dart';
import 'package:projectflow_web/presentation/features/auth/views/screens/register_screen.dart';
import 'package:projectflow_web/presentation/features/dashboard/views/screens/dashboard_screen.dart';
import 'package:projectflow_web/presentation/features/dashboard/views/widgets/sidebar_widget.dart';
import 'package:projectflow_web/presentation/features/projects/views/screens/project_detail_screen.dart';
import 'package:projectflow_web/presentation/features/projects/views/screens/projects_screen.dart';
import 'package:projectflow_web/presentation/features/tasks/views/screens/kanban_board_screen.dart';
import 'package:projectflow_web/presentation/features/tasks/views/screens/test_kanban.dart';

final GoRouter router = GoRouter(
  initialLocation: '/login',
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
     redirect: (context, state)  async {
       final localStorage = getIt.get<LocalStorage>();
       final token = await localStorage.load(key: "token", boxName: "userData");
       if (token != null) return '/dashboard';
       return null;
      },
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),

    ShellRoute(
      builder: (context, state, child) {
        return MainLayout(child: child);
      },
      routes: [
        GoRoute(
          path: '/dashboard',
          builder: (context, state) => const DashboardScreen(),
        ),
        GoRoute(
          path: '/projects',
          builder: (context, state) => const ProjectsScreen(),
          routes: [
           /* GoRoute(
              path: 'details/:id',
              builder: (context, state) {
                final id = state.pathParameters['id'];
                return ProjectDetailsScreen(projectId: id!);
              },
            ),*/
            GoRoute(
              path: 'details',
              builder: (context, state) {
                return const ProjectDetailScreen() ;
              },
            ),
          ],
        ),
        GoRoute(
          path: '/settings',
          builder: (context, state) =>
          const Center(child: Text("⚙️ Settings Screen")),
        ),
        GoRoute(
          path: '/kanban',
          builder: (context, state) {
            return  const KanbanBoard() ;
          },
        ),

      ],
    ),
  ],
);
