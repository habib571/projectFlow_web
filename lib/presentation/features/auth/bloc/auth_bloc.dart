import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:projectflow_web/core/cache/hive_local_storage.dart';
import 'package:projectflow_web/core/cache/local_storage.dart';
import 'package:projectflow_web/core/dependencyInjection/dependency_injector.dart';
import 'package:projectflow_web/core/services/firebase_notification_service.dart';
import 'package:projectflow_web/datasource/requests/auth_request.dart';
import 'package:projectflow_web/domain/repository/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  bool isLoginPasswordObscure = true;
  bool isRegisterPasswordObscure = true;

  final AuthRepository _authRepository;

  final LocalStorage _localStorage;

  AuthBloc(this._authRepository, this._localStorage) : super(AuthInitial()) {
    on<ToggleLoginPasswordVisibility>(_changeLoginPasswordVisibility);
    on<ToggleRegisterPasswordVisibility>(_changeRegisterPasswordVisibility);
    on<RegisterSubmit>(_registerSubmit);
    on<LoginSubmit>(_loginSubmit) ;
  }

  void _changeRegisterPasswordVisibility(ToggleRegisterPasswordVisibility event,
      Emitter emit) {
    isRegisterPasswordObscure = !isRegisterPasswordObscure;
    emit(RegisterPasswordVisibilityToggled(
        isObscure: isRegisterPasswordObscure));
  }

  void _changeLoginPasswordVisibility(ToggleLoginPasswordVisibility event,
      Emitter emit) {
    isLoginPasswordObscure = !isLoginPasswordObscure;
    emit(LoginPasswordVisibilityToggled(isObscure: isLoginPasswordObscure));
  }

  _registerSubmit(RegisterSubmit event, Emitter emit) async {
    emit(RegisterLoadingState());
    final result = await _authRepository.signup(event.authRequest);
    await result.fold(
          (failure) async {
        emit(RegisterFailureState(failure.message));
      },
      (data) async {
        await _localStorage.save(
            key: "token", value: data.token, boxName: "userData");
        
        // Save FCM token to backend
        try {
          final fcmToken = await getIt<FirebaseNotificationService>().getToken();
          if (fcmToken != null) {
            final saveTokenResult = await _authRepository.saveDeviceToken(fcmToken);
            saveTokenResult.fold(
              (l) => log("Failed to save FCM token: ${l.message}"),
              (r) => log("Device token registered: ${r.status}, ${r.message}"),
            );
          }
        } catch (e) {
          log("Failed to save FCM token: $e");
        }
        
        emit(RegisterSuccessState());
      },
    );
  }

  _loginSubmit(LoginSubmit event, Emitter emit) async {
    emit(LoginLoadingState());
    final result = await _authRepository.login(event.authRequest);
    await result.fold(
          (failure) async {
        emit(LoginFailureState(failure.message));
      }, (data) async {
      await _localStorage.save(
          key: "token", value: data.token, boxName: "userData");
      //getIt.get<TokenManager>().getToken() ;
      emit(LoginSuccessState());
    },
    );
  }
}