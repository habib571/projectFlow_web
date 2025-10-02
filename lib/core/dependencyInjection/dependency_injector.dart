import 'package:get_it/get_it.dart';
import 'package:projectflow_web/core/dependencyInjection/dependencies/auth_dependencies.dart';

final getIt = GetIt.I;
void configureDependencies() {
  AuthDependency.init();
}
