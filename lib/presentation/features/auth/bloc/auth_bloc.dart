import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:projectflow_web/datasource/requests/auth_request.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  bool isLoginPasswordObscure = true;
  bool isRegisterPasswordObscure = true ;
  AuthBloc() : super(AuthInitial()) {
    on<ToggleLoginPasswordVisibility>(_changeLoginPasswordVisibility) ;
    on<ToggleRegisterPasswordVisibility>(_changeRegisterPasswordVisibility) ;

  }
  void _changeRegisterPasswordVisibility(ToggleRegisterPasswordVisibility event, Emitter emit) {
    isRegisterPasswordObscure = !isRegisterPasswordObscure;
    emit(RegisterPasswordVisibilityToggled(isObscure: isRegisterPasswordObscure));
  }
  void _changeLoginPasswordVisibility(
      ToggleLoginPasswordVisibility event, Emitter emit) {
    isLoginPasswordObscure = !isLoginPasswordObscure;
    emit(LoginPasswordVisibilityToggled(isObscure: isLoginPasswordObscure));
  }
}
