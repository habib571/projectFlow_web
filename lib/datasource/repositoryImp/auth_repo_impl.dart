import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:projectflow_web/core/api/error_handler.dart';
import 'package:projectflow_web/core/api/failure.dart';
import 'package:projectflow_web/core/network/internet_checker.dart';
import 'package:projectflow_web/datasource/remotedatasource/auth_remote_data_source.dart';
import 'package:projectflow_web/datasource/requests/auth_request.dart';
import 'package:projectflow_web/datasource/responses/auth_response.dart';
import 'package:projectflow_web/datasource/responses/device_token_response.dart';
import 'package:projectflow_web/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;
  final NetworkInfo _networkInfo;

  AuthRepositoryImpl(this._authRemoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, AuthResponse>> signup(AuthRequest authRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _authRemoteDataSource.signup(authRequest);
        if (response.statusCode == 200) {
          return Right(AuthResponse.fromJson(response.data));
        } else {
          return Left(Failure.fromJson(response.data));
        }
      } catch (error) {
        log("errrorr:$error");
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
  }

  @override
  Future<Either<Failure, AuthResponse>> login(AuthRequest authRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _authRemoteDataSource.login(authRequest);
        if (response.statusCode == 200) {
          return Right(AuthResponse.fromJson(response.data));
        } else {
          return Left(Failure.fromJson(response.data));
        }
      } catch (error) {
        log("errrorr:$error");
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
  }

  @override
  Future<Either<Failure, DeviceTokenResponse>> saveDeviceToken(String token) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _authRemoteDataSource.saveDeviceToken(token);
        if (response.statusCode == 200) {
          return Right(DeviceTokenResponse.fromJson(response.data));
        } else {
          return Left(Failure.fromJson(response.data));
        }
      } catch (error) {
        log("errrorr:$error");
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
  }
}