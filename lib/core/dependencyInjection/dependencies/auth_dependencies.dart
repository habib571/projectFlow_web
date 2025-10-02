

import 'package:projectflow_web/core/dependencyInjection/dependency_injector.dart';
import 'package:projectflow_web/presentation/features/auth/bloc/auth_bloc.dart';

class AuthDependency {
  AuthDependency._();
  static void init() {
/*
    getIt.registerLazySingleton<AuthRemoteDataSource>(
            () => AuthRemoteDataSourceImpl(getIt()));
    getIt.registerLazySingleton<AuthRepository>(
            () => AuthRepositoryImpl(getIt(), getIt()));

    getIt.registerFactory<SignupUseCase>(() => SignupUseCase(getIt()));
    getIt.registerFactory<VerifyOtpUseCase>(() => VerifyOtpUseCase(getIt()));
    getIt.registerFactory<LoginUseCase>(() => LoginUseCase(getIt()));
    getIt.registerFactory<SaveDeviceTokenUseCase>(() => SaveDeviceTokenUseCase(getIt()));*/

    getIt.registerFactory<AuthBloc>(
            () => AuthBloc());
  }
}
