
import 'package:auto_route/auto_route.dart';
import 'package:projectflow_web/core/routes/app_routes.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: LoginRoute.page ,initial: true) ,


  ];
}