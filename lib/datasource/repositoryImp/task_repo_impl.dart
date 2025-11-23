import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:projectflow_web/core/api/error_handler.dart';
import 'package:projectflow_web/core/api/failure.dart';
import 'package:projectflow_web/core/network/internet_checker.dart';
import 'package:projectflow_web/datasource/remotedatasource/task_data_source.dart';
import 'package:projectflow_web/datasource/requests/add_task_request.dart';
import 'package:projectflow_web/datasource/requests/pagination_request.dart';
import 'package:projectflow_web/datasource/responses/paginated_list_response.dart';
import 'package:projectflow_web/domain/models/task_model.dart';
import 'package:projectflow_web/domain/repository/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskDataSource _taskDataSource;
  final NetworkInfo _networkInfo;
  TaskRepositoryImpl(this._taskDataSource, this._networkInfo);

  @override
  Future<Either<Failure, TaskModel>> addTask(
      AddTaskRequest projectRequest, int projectId) async {
    if (await _networkInfo.isConnected) {
      try {
        final response =
            await _taskDataSource.addTask(projectRequest, projectId);
        if (response.statusCode == 200) {
          return Right(TaskModel.fromJson(response.data));
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
  Future<Either<Failure, PaginatedListResponse<TaskModel>>> getTasks(
      int projectId , PaginationRequest pagination) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _taskDataSource.getTasks(projectId,pagination) ;
        if (response.statusCode == 200) {
          final result = PaginatedListResponse<TaskModel>.fromJson(
            response.data,
            (json) => TaskModel.fromJson(json),
          );
          return Right(result);
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
