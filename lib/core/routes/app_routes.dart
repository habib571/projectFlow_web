

import 'package:go_router/go_router.dart';
import 'package:projectflow_web/presentation/features/auth/views/screens/login_screen.dart';
import 'package:projectflow_web/presentation/features/auth/views/screens/register_screen.dart';
import 'package:projectflow_web/presentation/features/dashboard/views/widgets/sidebar_widget.dart';

final GoRouter router = GoRouter(
  initialLocation: '/mainLayout',
  debugLogDiagnostics: true,
  routes: [

    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
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
    GoRoute(
      path: '/mainLayout',
      builder: (context, state) =>  const MainLayout(),
    ),


  ],
);
