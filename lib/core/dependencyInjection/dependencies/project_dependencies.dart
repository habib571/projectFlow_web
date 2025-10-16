import 'package:projectflow_web/core/dependencyInjection/dependency_injector.dart';
import 'package:projectflow_web/datasource/remotedatasource/project_remote_data_source.dart';
import 'package:projectflow_web/datasource/repositoryImp/project_repo_impl.dart';
import 'package:projectflow_web/domain/repository/project_repository.dart';
import 'package:projectflow_web/presentation/features/projects/bloc/project_bloc.dart';

class ProjectDependencies {
 ProjectDependencies._() ;
 static void init() {
   getIt.registerLazySingleton<ProjectDataSource>(
           () => ProjectDataSourceImpl(getIt()));
   getIt.registerLazySingleton<ProjectRepository>(
           () => ProjectRepositoryImpl(getIt(), getIt()));
   getIt.registerFactory<ProjectBloc>(
           () => ProjectBloc(getIt()));
 }
}