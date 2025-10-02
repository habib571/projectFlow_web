

import 'package:go_router/go_router.dart';
import 'package:projectflow_web/presentation/features/auth/views/screens/login_screen.dart';
import 'package:projectflow_web/presentation/features/auth/views/screens/register_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/login',
  debugLogDiagnostics: true,
  routes: [

    GoRoute(
      path: '/login',
      builder: (context, state) => LoginScreen(),
      /*  redirect: (context, state) {
         final station = LocalStorage.getStationFromLocal();
          if (station != null) {
            return '/dashboard';
          }
          return null;
        }*/
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),

  ],
);
