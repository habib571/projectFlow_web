import 'package:projectflow_web/domain/models/user_model.dart';

class AuthResponse {
  final String? token ;
  final UserModel? userModel ;
  AuthResponse(this.token, this.userModel);
  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      json['token'] as String ,
      json['user'] != null ? UserModel.fromJson(json['user']) : null,
    );
  }
}