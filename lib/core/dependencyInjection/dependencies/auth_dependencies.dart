

import 'package:projectflow_web/core/dependencyInjection/dependency_injector.dart';
import 'package:projectflow_web/datasource/remotedatasource/auth_remote_data_source.dart';
import 'package:projectflow_web/datasource/repositoryImp/auth_repo_impl.dart';
import 'package:projectflow_web/domain/repository/auth_repository.dart';
import 'package:projectflow_web/presentation/features/auth/bloc/auth_bloc.dart';

class AuthDependency {
  AuthDependency._();
  static void init() {

    getIt.registerLazySingleton<AuthRemoteDataSource>(
            () => AuthRemoteDataSourceImpl(getIt()));
    getIt.registerLazySingleton<AuthRepository>(
            () => AuthRepositoryImpl(getIt(), getIt()));
    getIt.registerFactory<AuthBloc>(
            () => AuthBloc(getIt(), getIt()));
  }
}
