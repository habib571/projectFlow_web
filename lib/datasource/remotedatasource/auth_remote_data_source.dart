

import 'dart:developer';

import 'package:projectflow_web/core/api/api_client.dart';
import 'package:projectflow_web/core/api/api_response.dart';
import 'package:projectflow_web/datasource/requests/auth_request.dart';

abstract class AuthRemoteDataSource {
  Future<ApiResponse> signup(AuthRequest authRequest);
  Future<ApiResponse> login(AuthRequest authRequest);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient _apiClient;
  AuthRemoteDataSourceImpl(this._apiClient);

  @override
  Future<ApiResponse> signup(AuthRequest authRequest) async {
    return await _apiClient.execute(
        isTokenRequired: false,
        body: authRequest.toJsonRegister(),
        method: Method.post,
        url: "auth/signup",
        onRequestResponse: (response, statusCode) {
          log(response.toString());
          return ApiResponse(response, statusCode);
        });
  }


  @override
  Future<ApiResponse> login(AuthRequest authRequest) async {
    return await _apiClient.execute(
        isTokenRequired: false,
        body: authRequest.toJsonLogin(),
        method: Method.post,
        url: "auth/login",
        onRequestResponse: (response, statusCode) {
          return ApiResponse(response, statusCode);
        });
  }


}
