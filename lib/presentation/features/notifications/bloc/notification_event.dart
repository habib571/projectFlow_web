part of 'notification_bloc.dart';

sealed class NotificationEvent extends Equatable {
  const NotificationEvent();
}

final class GetNotificationsEvent extends NotificationEvent {
  final PaginationRequest pagination;
  const GetNotificationsEvent(this.pagination);

  @override
  List<Object?> get props => [pagination];
}

final class MarkAsReadEvent extends NotificationEvent {
  final int id;
  const MarkAsReadEvent(this.id);

  @override
  List<Object?> get props => [id];
}

final class GetUnreadCountEvent extends NotificationEvent {
  const GetUnreadCountEvent();

  @override
  List<Object?> get props => [];
}

final class NewNotificationReceivedEvent extends NotificationEvent {
  const NewNotificationReceivedEvent();

  @override
  List<Object?> get props => [];
}
