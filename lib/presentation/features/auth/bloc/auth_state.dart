part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();
}

final class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}
final class RegisterLoadingState extends AuthState{
  @override

  List<Object?> get props => [] ;
}
final class RegisterFailureState extends AuthState{
  final String message ;
  const RegisterFailureState(this.message);

  @override

  List<Object?> get props => [message] ;
}
final class RegisterSuccessState extends AuthState{
  @override

  List<Object?> get props => [] ;
}
class RegisterPasswordVisibilityToggled extends AuthState {
  final bool isObscure;
  const RegisterPasswordVisibilityToggled({required this.isObscure,});

  @override

  List<Object?> get props => [isObscure];
}

////////////////////login////////////////////////////////

final class LoginLoadingState extends AuthState{
  @override
  List<Object?> get props => [] ;
}
final class LoginFailureState extends AuthState{
  final String message ;
  const LoginFailureState(this.message);

  @override
  List<Object?> get props => [message] ;
}
final class LoginSuccessState extends AuthState {
  @override
  List<Object?> get props => [] ;
}

class LoginPasswordVisibilityToggled extends AuthState {
  final bool isObscure;
  const LoginPasswordVisibilityToggled({required this.isObscure});

  @override
  List<Object?> get props => [isObscure] ;
}