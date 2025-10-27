import 'package:projectflow_web/core/dependencyInjection/dependency_injector.dart';
import 'package:projectflow_web/presentation/features/tasks/bloc/task_bloc.dart';

class TaskDependencies {
  TaskDependencies._() ;
  static void init() {
  /*  getIt.registerLazySingleton<TaskDataSource>(
            () => TaskDataSourceImpl(getIt()));
    getIt.registerLazySingleton<TaskRepository>(
            () => TaskRepositoryImpl(getIt(), getIt())); */
    getIt.registerLazySingleton<TaskBloc>(
            () => TaskBloc());
  }
}