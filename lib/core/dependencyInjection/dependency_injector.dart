import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:projectflow_web/core/api/api_client.dart';
import 'package:projectflow_web/core/cache/hive_local_storage.dart';
import 'package:projectflow_web/core/cache/local_storage.dart';
import 'package:projectflow_web/core/dependencyInjection/dependencies/auth_dependencies.dart';
import 'package:projectflow_web/core/dependencyInjection/dependencies/meeting_dependencies.dart';
import 'package:projectflow_web/core/dependencyInjection/dependencies/project_dependencies.dart';
import 'package:projectflow_web/core/dependencyInjection/dependencies/task_dependencies.dart';
import 'package:projectflow_web/core/network/internet_checker.dart';
import 'package:projectflow_web/presentation/features/dashboard/bloc/navigation_bloc.dart';
import 'package:projectflow_web/presentation/utils/app_context.dart';

final getIt = GetIt.I;
void configureDependencies() {
  getIt.registerLazySingleton(()=>AppContext()) ;
  getIt.registerLazySingleton<LocalStorage>(()=>HiveLocalStorage()) ;
  getIt.registerLazySingleton<ApiClient>(() => ApiClient(getIt()));
  getIt.registerLazySingleton<NetworkInfo>(
          () => NetworkInfoImpl(InternetConnectionChecker.instance));
  getIt.registerLazySingleton(()=>NavigationBloc()) ;
  AuthDependency.init();
  ProjectDependencies.init();
  TaskDependencies.init();
  MeetingDependencies.init();
}
