import 'package:dartz/dartz.dart';
import 'package:projectflow_web/core/api/failure.dart';
import 'package:projectflow_web/datasource/requests/pagination_request.dart';
import 'package:projectflow_web/datasource/responses/paginated_list_response.dart';
import 'package:projectflow_web/domain/models/notification_model.dart';

abstract class NotificationRepository {
  Future<Either<Failure, PaginatedListResponse<NotificationModel>>> getNotifications(
      PaginationRequest pagination);
  Future<Either<Failure, void>> markAsRead(int id);
  Future<Either<Failure, int>> getUnreadCount();
}
