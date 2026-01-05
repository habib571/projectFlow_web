import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_messaging/firebase_messaging.dart'; // Added for RemoteMessage
import 'package:projectflow_web/core/dependencyInjection/dependency_injector.dart';
import 'package:projectflow_web/core/helpers/extensions/screen_config_extension.dart';
import 'package:projectflow_web/core/services/firebase_notification_service.dart';
import 'package:projectflow_web/generated/assets.dart';
import 'package:projectflow_web/presentation/features/dashboard/bloc/navigation_bloc.dart';
import 'package:projectflow_web/presentation/features/meetings/videocallbloc/video_call_bloc.dart';
import 'package:projectflow_web/presentation/features/notifications/bloc/notification_bloc.dart';
import 'package:projectflow_web/presentation/features/projects/bloc/project_bloc.dart';
import 'package:projectflow_web/presentation/features/tasks/bloc/task_bloc.dart';
import 'package:projectflow_web/presentation/sharedwidgets/image_placeholder.dart';
import 'package:projectflow_web/presentation/theme/colors.dart';
import 'package:projectflow_web/presentation/theme/styles.dart';
import 'package:projectflow_web/presentation/features/notifications/views/widgets/notification_toast.dart'; // Added import

import '../../../meetings/meetingbloc/meeting_bloc.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key, required this.child});
  final Widget child;

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  StreamSubscription? _notificationSubscription;

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
  }

  Future<void> _initializeNotifications() async {
    final notificationService = getIt<FirebaseNotificationService>();

    // Subscribe immediately
    print("SidebarWidget: Subscribing to notification stream");
    _notificationSubscription = notificationService.onMessageStream.listen((message) {
      print("SidebarWidget: Message received: ${message.messageId}");
      if (mounted) {
        print("SidebarWidget: Adding NewNotificationReceivedEvent to Bloc");
        getIt<NotificationBloc>().add(const NewNotificationReceivedEvent());
        _showNotificationToast(message);
      } else {
        print("SidebarWidget: Not mounted, skipping update");
      }
    });

    // Initialize (request permission, get token) in parallel
    try {
      await notificationService.initialize();
    } catch (e) {
      print("SidebarWidget: Initialization failed or timed out: $e");
    }


  }

  void _showNotificationToast(RemoteMessage message) {
    if (!mounted) return;
    print("SidebarWidget: Showing Toast for message: ${message.messageId}");

    try {
      final overlayState = Overlay.of(context, rootOverlay: true);
      if (overlayState == null) {
        print("SidebarWidget: OverlayState is null!");
        return;
      }

      late OverlayEntry overlayEntry;

      overlayEntry = OverlayEntry(
        builder: (context) => Positioned(
          top: 20, // Increased top margin
          right: 20,
          child: Material(
            color: Colors.transparent,
            child: NotificationToast(
              message: message,
              onDismiss: () {
                if (overlayEntry.mounted) {
                  overlayEntry.remove();
                }
              },
            ),
          ),
        ),
      );

      overlayState.insert(overlayEntry);
      print("SidebarWidget: Proxy Toast inserted into overlay");

      // Auto remove after 5 seconds
      Future.delayed(const Duration(seconds: 5), () {
        if (overlayEntry.mounted) {
          overlayEntry.remove();
        }
      });
    } catch (e) {
      print("SidebarWidget: Error showing toast: $e");
    }
  }

  @override
  void dispose() {
    _notificationSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<NavigationBloc>()),
        BlocProvider(create: (_) => getIt<ProjectBloc>()),
        BlocProvider(create: (_) => getIt<TaskBloc>()),
        BlocProvider(create: (_) => getIt<MeetingBloc>()),
        BlocProvider(create: (_) => getIt<VideoCallBloc>()),
        BlocProvider.value(value: getIt<NotificationBloc>()..add(const GetUnreadCountEvent())),
      ],
      child: Scaffold(
        body: BlocBuilder<NavigationBloc, NavigationState>(
          buildWhen: (previous, current) => current is ItemSelectedState,
          builder: (context, state) {
            final bloc = context.read<NavigationBloc>();
            final selectedIndex = bloc.state is ItemSelectedState
                ? (bloc.state as ItemSelectedState).selectedIndex
                : 0;

            return Row(
              children: [
                Container(
                  width: 270.w,
                  color: Colors.white,
                  child: Padding(
                    padding:
                     EdgeInsets.symmetric(vertical: 20, horizontal: 20.w),
                    child: Column(
                      children: [
                        // Logo
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppColors.primary500,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: SvgPicture.asset(
                                Assets.imagesLogo,
                                color: Colors.white,
                                height: 24,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'ProjectFlow',
                              style: sataoshiBold.copyWith(fontSize: 20),
                            ),
                          ],
                        ),
                        const SizedBox(height: 50),

                        // Sidebar items
                        Expanded(
                          child: ListView(
                            children: [
                              _buildNavItem(
                                context,
                                icon: Icons.dashboard_outlined,
                                selectedIcon: Icons.dashboard,
                                label: "Dashboard",
                                index: 0,
                                selectedIndex: selectedIndex,
                                onTap: () {
                                  bloc.add(const NavigationItemSelected(0));
                                  context.go('/dashboard');
                                },
                              ),
                              _buildNavItem(
                                context,
                                icon: Icons.folder_outlined,
                                selectedIcon: Icons.folder,
                                label: "Projects",
                                index: 1,
                                selectedIndex: selectedIndex,
                                onTap: () {
                                  bloc.add(const NavigationItemSelected(1));
                                  context.go('/projects');
                                },
                              ),
                              _buildNavItem(
                                context,
                                icon: Icons.check_circle_outline,
                                selectedIcon: Icons.check_circle,
                                label: "Tasks",
                                index: 2,
                                selectedIndex: selectedIndex,
                                onTap: () {
                                  bloc.add(const NavigationItemSelected(2));
                                  context.go('/tasks');
                                },
                              ),
                              _buildNavItem(
                                context,
                                icon: Icons.people_outline,
                                selectedIcon: Icons.people,
                                label: "Team",
                                index: 3,
                                selectedIndex: selectedIndex,
                                onTap: () {
                                  bloc.add(const NavigationItemSelected(3));
                                  context.go('/team');
                                },
                              ),
                              _buildNavItem(
                                context,
                                icon: Icons.settings_outlined,
                                selectedIcon: Icons.settings,
                                label: "Settings",
                                index: 4,
                                selectedIndex: selectedIndex,
                                onTap: () {
                                  bloc.add(const NavigationItemSelected(4));
                                  context.go('/settings');
                                },
                              ),
                              BlocBuilder<NotificationBloc, NotificationState>(
                                buildWhen: (prev, curr) => curr is UnreadCountUpdated,
                                builder: (context, notifState) {
                                  final notifBloc = context.read<NotificationBloc>();
                                  return _buildNavItemWithBadge(
                                    context,
                                    icon: Icons.notifications_outlined,
                                    selectedIcon: Icons.notifications,
                                    label: "Notifications",
                                    index: 5,
                                    selectedIndex: selectedIndex,
                                    badgeCount: notifBloc.unreadCount,
                                    onTap: () {
                                      bloc.add(const NavigationItemSelected(5));
                                      context.go('/notifications');
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),

                        // Footer (User info)
                        const Divider(),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                           ImagePlaceHolderWeb(radius: 18, fullName: "H") ,
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Alex Turner",
                                    style: sataoshiMedium.copyWith(
                                      fontSize: 14,
                                      color: AppColors.primary500,
                                    ),
                                  ),
                                  Text(
                                    "alex@projectflow.com",
                                    style: sataoshiRegular.copyWith(
                                      fontSize: 12,
                                      color: AppColors.primaryGrey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(Icons.logout,
                                size: 18, color: AppColors.primaryGrey),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: const Color(0xffFAFAFA),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width - 100,
                        ),
                        child: widget.child,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildNavItem(
      BuildContext context, {
        required IconData icon,
        required IconData selectedIcon,
        required String label,
        required int index,
        required int selectedIndex,
        required VoidCallback onTap,
      }) {
    final bool isSelected = index == selectedIndex;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary300.withOpacity(0.2) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
          child: Row(
            children: [
              Icon(
                isSelected ? selectedIcon : icon,
                color: isSelected
                    ? AppColors.primary500
                    : AppColors.primaryTxt,
                size: 22,
              ),
              const SizedBox(width: 10),
              Text(
                label,
                style: sataoshiMedium.copyWith(
                  fontSize: 15,
                  color: isSelected
                      ? AppColors.primary500
                      : AppColors.primaryTxt
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItemWithBadge(
      BuildContext context, {
        required IconData icon,
        required IconData selectedIcon,
        required String label,
        required int index,
        required int selectedIndex,
        required int badgeCount,
        required VoidCallback onTap,
      }) {
    final bool isSelected = index == selectedIndex;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary300.withValues(alpha: 0.2) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
          child: Row(
            children: [
              Badge(
                isLabelVisible: badgeCount > 0,
                label: Text(
                  badgeCount > 99 ? '99+' : badgeCount.toString(),
                  style: const TextStyle(fontSize: 10, color: Colors.white),
                ),
                backgroundColor: Colors.red,
                child: Icon(
                  isSelected ? selectedIcon : icon,
                  color: isSelected
                      ? AppColors.primary500
                      : AppColors.primaryTxt,
                  size: 22,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  label,
                  style: sataoshiMedium.copyWith(
                    fontSize: 15,
                    color: isSelected
                        ? AppColors.primary500
                        : AppColors.primaryTxt
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
