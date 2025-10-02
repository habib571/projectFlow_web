part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();
}
class RegisterSubmit extends AuthEvent {
  final AuthRequest authRequest;
  const RegisterSubmit(this.authRequest);

  @override

  List<Object?> get props => [] ;
}
class LoginSubmit extends AuthEvent {
  final AuthRequest authRequest;
  const LoginSubmit(this.authRequest);

  @override
  List<Object?> get props => [authRequest] ;
}
class ToggleRegisterPasswordVisibility extends AuthEvent {
  @override
  List<Object?> get props => [] ;
}

class ToggleLoginPasswordVisibility extends AuthEvent {
  @override
  List<Object?> get props => [] ;
}
