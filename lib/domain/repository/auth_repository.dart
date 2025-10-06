import 'package:dartz/dartz.dart';
import 'package:projectflow_web/core/api/failure.dart';
import 'package:projectflow_web/datasource/requests/auth_request.dart';
import 'package:projectflow_web/datasource/responses/auth_response.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthResponse>> signup(AuthRequest authRequest);
  Future<Either<Failure, AuthResponse>> login(AuthRequest authRequest);
}