import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectflow_web/datasource/requests/pagination_request.dart';
import 'package:projectflow_web/presentation/features/notifications/bloc/notification_bloc.dart';
import 'package:projectflow_web/presentation/features/notifications/views/widgets/notification_card.dart';
import 'package:projectflow_web/presentation/theme/colors.dart';
import 'package:projectflow_web/presentation/theme/styles.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../domain/models/notification_model.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 0;
  final int _pageSize = 10;
  bool _isLoadingMore = false;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _loadNotifications();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _loadNotifications() {
    context.read<NotificationBloc>().add(
          GetNotificationsEvent(PaginationRequest(_currentPage, _pageSize)),
        );
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_isLoadingMore &&
        _hasMore) {
      _loadMore();
    }
  }

  void _loadMore() {
    setState(() {
      _isLoadingMore = true;
      _currentPage++;
    });
    _loadNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Notifications",
                style: sataoshiBold.copyWith(fontSize: 24),
              ),
              TextButton.icon(
                onPressed: () {
                  // Mark all as read functionality
                },
                icon: const Icon(Icons.done_all, size: 18),
                label: Text(
                  "Mark all as read",
                  style: sataoshiMedium.copyWith(
                    color: AppColors.primary500,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Notifications List
          Expanded(
            child: BlocConsumer<NotificationBloc, NotificationState>(
              listener: (context, state) {
                if (state is GetNotificationsSuccess) {
                  setState(() {
                    _isLoadingMore = false;
                    _hasMore = !state.response.pagination.isLastPage;
                  });
                }
                if (state is GetNotificationsFailure) {
                  setState(() {
                    _isLoadingMore = false;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.failure.message)),
                  );
                }
              },
              builder: (context, state) {
                final bloc = context.read<NotificationBloc>();
                final notifications = bloc.notifications;

                if (state is GetNotificationsLoading && notifications.isEmpty) {
                  return _buildSkeletonList();
                }

                if (notifications.isEmpty) {
                  return _buildEmptyState();
                }

                return Card(
                  elevation: 1,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListView.separated(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(16),
                    itemCount: notifications.length + (_isLoadingMore ? 1 : 0),
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      if (index == notifications.length) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }

                      final notification = notifications[index];
                      return NotificationCard(
                        notification: notification,
                        onTap: () {
                          if (!notification.read) {
                            context
                                .read<NotificationBloc>()
                                .add(MarkAsReadEvent(notification.id));
                          }
                          // Navigate based on notification type if needed
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkeletonList() {
    return Skeletonizer(
      enabled: true,
      child: Card(
        elevation: 1,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: 5,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            return NotificationCard(
              notification: NotificationModel(
                id: index,
                title: 'TASK_ASSIGNED',
                body: {
                  'actorName': 'John Doe',
                  'projectName': 'Project Name',
                  'taskName': 'Task Name',
                },
                sentAt: DateTime.now(),
                read: false,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_off_outlined,
            size: 64,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            "No notifications yet",
            style: sataoshiMedium.copyWith(
              fontSize: 18,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "You'll see notifications here when you receive them",
            style: sataoshiRegular.copyWith(
              fontSize: 14,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }
}
