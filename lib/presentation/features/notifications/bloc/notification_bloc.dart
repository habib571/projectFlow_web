import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:projectflow_web/core/api/failure.dart';
import 'package:projectflow_web/datasource/requests/pagination_request.dart';
import 'package:projectflow_web/datasource/responses/paginated_list_response.dart';
import 'package:projectflow_web/domain/models/notification_model.dart';
import 'package:projectflow_web/domain/repository/notification_repository.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationRepository _notificationRepository;

  NotificationBloc(this._notificationRepository) : super(NotificationInitial()) {
    on<GetNotificationsEvent>(_getNotifications);
    on<MarkAsReadEvent>(_markAsRead);
    on<GetUnreadCountEvent>(_getUnreadCount);
    on<NewNotificationReceivedEvent>(_onNewNotificationReceived);
  }

  List<NotificationModel> notifications = [];
  int unreadCount = 0;

  Future<void> _getNotifications(
      GetNotificationsEvent event, Emitter<NotificationState> emit) async {
    emit(GetNotificationsLoading());
    final result = await _notificationRepository.getNotifications(event.pagination);
    result.fold(
      (failure) => emit(GetNotificationsFailure(failure)),
      (response) {
        notifications = response.data;
        emit(GetNotificationsSuccess(response));
      },
    );
  }

  Future<void> _markAsRead(
      MarkAsReadEvent event, Emitter<NotificationState> emit) async {
    emit(MarkAsReadLoading());
    final result = await _notificationRepository.markAsRead(event.id);
    result.fold(
      (failure) => emit(MarkAsReadFailure(failure)),
      (_) {
        // Update local notification list
        final index = notifications.indexWhere((n) => n.id == event.id);
        if (index != -1) {
          final updated = NotificationModel(
            id: notifications[index].id,
            title: notifications[index].title,
            body: notifications[index].body,
            sentAt: notifications[index].sentAt,
            read: true,
          );
          notifications[index] = updated;
          if (unreadCount > 0) unreadCount--;
        }
        emit(MarkAsReadSuccess(event.id));
        emit(UnreadCountUpdated(unreadCount));
      },
    );
  }

  Future<void> _getUnreadCount(
      GetUnreadCountEvent event, Emitter<NotificationState> emit) async {
    final result = await _notificationRepository.getUnreadCount();
    result.fold(
      (failure) => emit(GetUnreadCountFailure(failure)),
      (count) {
        unreadCount = count;
        emit(UnreadCountUpdated(count));
      },
    );
  }

  void _onNewNotificationReceived(
      NewNotificationReceivedEvent event, Emitter<NotificationState> emit) {
    log("NotificationBloc: NewNotificationReceivedEvent received. Current unreadCount: $unreadCount");
    unreadCount++;
    log("NotificationBloc: Incrementing unreadCount to: $unreadCount");
    emit(UnreadCountUpdated(unreadCount));
  }
}
