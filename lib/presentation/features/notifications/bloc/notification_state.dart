part of 'notification_bloc.dart';

sealed class NotificationState extends Equatable {
  const NotificationState();
}

final class NotificationInitial extends NotificationState {
  @override
  List<Object> get props => [];
}

// Get Notifications States
final class GetNotificationsLoading extends NotificationState {
  @override
  List<Object> get props => [];
}

final class GetNotificationsSuccess extends NotificationState {
  final PaginatedListResponse<NotificationModel> response;
  const GetNotificationsSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

final class GetNotificationsFailure extends NotificationState {
  final Failure failure;
  const GetNotificationsFailure(this.failure);

  @override
  List<Object?> get props => [failure];
}

// Mark As Read States
final class MarkAsReadLoading extends NotificationState {
  @override
  List<Object> get props => [];
}

final class MarkAsReadSuccess extends NotificationState {
  final int id;
  const MarkAsReadSuccess(this.id);

  @override
  List<Object?> get props => [id];
}

final class MarkAsReadFailure extends NotificationState {
  final Failure failure;
  const MarkAsReadFailure(this.failure);

  @override
  List<Object?> get props => [failure];
}

// Unread Count States
final class UnreadCountUpdated extends NotificationState {
  final int count;
  const UnreadCountUpdated(this.count);

  @override
  List<Object?> get props => [count];
}

final class GetUnreadCountFailure extends NotificationState {
  final Failure failure;
  const GetUnreadCountFailure(this.failure);

  @override
  List<Object?> get props => [failure];
}
