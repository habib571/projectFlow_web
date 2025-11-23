import 'package:dartz/dartz.dart';
import 'package:projectflow_web/core/api/failure.dart';
import 'package:projectflow_web/datasource/requests/add_task_request.dart';
import 'package:projectflow_web/datasource/requests/pagination_request.dart';
import 'package:projectflow_web/datasource/responses/paginated_list_response.dart';
import 'package:projectflow_web/domain/models/task_model.dart';

abstract class TaskRepository {
  Future<Either<Failure, TaskModel>> addTask(
      AddTaskRequest projectRequest, int projectId);
  Future<Either<Failure, PaginatedListResponse<TaskModel>>> getTasks(
      int projectId, PaginationRequest pagination);
}
