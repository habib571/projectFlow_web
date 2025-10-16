import 'package:go_router/go_router.dart';
import 'package:projectflow_web/core/cache/local_storage.dart';
import 'package:projectflow_web/core/dependencyInjection/dependency_injector.dart';
import 'package:projectflow_web/presentation/features/auth/views/screens/login_screen.dart';
import 'package:projectflow_web/presentation/features/auth/views/screens/register_screen.dart';
import 'package:projectflow_web/presentation/features/dashboard/views/widgets/sidebar_widget.dart';

final GoRouter router = GoRouter(
  initialLocation: '/login',
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      /*  redirect: (context, state) {
          final token =
              getIt.get<LocalStorage>().load(key: "token", boxName: "userData");
          if (token != null) {
            return '/mainLayout';
          }
          return null;
        }*/
        ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/mainLayout',
      builder: (context, state) => const MainLayout(),
    ),
  ],
);
