import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:projectflow_web/core/api/error_handler.dart';
import 'package:projectflow_web/core/api/failure.dart';
import 'package:projectflow_web/core/network/internet_checker.dart';
import 'package:projectflow_web/datasource/remotedatasource/notification_data_source.dart';
import 'package:projectflow_web/datasource/requests/pagination_request.dart';
import 'package:projectflow_web/datasource/responses/paginated_list_response.dart';
import 'package:projectflow_web/domain/models/notification_model.dart';
import 'package:projectflow_web/domain/repository/notification_repository.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationDataSource _notificationDataSource;
  final NetworkInfo _networkInfo;

  NotificationRepositoryImpl(this._notificationDataSource, this._networkInfo);

  @override
  Future<Either<Failure, PaginatedListResponse<NotificationModel>>> getNotifications(
      PaginationRequest pagination) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _notificationDataSource.getNotifications(pagination);
        if (response.statusCode == 200) {
          final result = PaginatedListResponse<NotificationModel>.fromJson(
            response.data,
            (json) => NotificationModel.fromJson(json),
          );
          return Right(result);
        } else {
          return Left(Failure.fromJson(response.data));
        }
      } catch (error) {
        log("error: $error");
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
  }

  @override
  Future<Either<Failure, void>> markAsRead(int id) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _notificationDataSource.markAsRead(id);
        if (response.statusCode == 200) {
          return const Right(null);
        } else {
          return Left(Failure.fromJson(response.data));
        }
      } catch (error) {
        log("error: $error");
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
  }

  @override
  Future<Either<Failure, int>> getUnreadCount() async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _notificationDataSource.getUnreadCount();
        if (response.statusCode == 200) {
          return Right(response.data as int? ?? 0);
        } else {
          return Left(Failure.fromJson(response.data));
        }
      } catch (error) {
        log("error: $error");
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
  }
}
