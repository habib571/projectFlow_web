import 'package:flutter/material.dart';
import 'package:projectflow_web/core/helpers/video_call_window_helper.dart';
import 'package:projectflow_web/domain/models/meeting.dart';
import 'package:projectflow_web/presentation/features/meetings/view/widgets/overlapped_images.dart';
import 'package:projectflow_web/presentation/theme/colors.dart';
import 'package:projectflow_web/presentation/theme/styles.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MeetingCard extends StatelessWidget {
  final Meeting meeting;
  final bool isLoading;
  final Function() onTap;
  const MeetingCard({
    super.key,
    required this.meeting,
    required this.isLoading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isOngoing = meeting.status == MeetingStatus.ONGOING;
    final isEnded = meeting.status == MeetingStatus.ENDED;
    final isInstant = meeting.type == MeetingType.INSTANT;

    return InkWell(
      onTap: () {
        VideoCallWindowHelper.openVideoCallWindow(
          meetingId: meeting.id ?? 0,
        );
      },
      child: Skeletonizer(
        enabled: isLoading,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 6),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left Section: Meeting info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        // Dot indicator (added for all statuses)
                        Icon(
                          Icons.circle,
                          size: 10,
                          color: isOngoing
                              ? Colors.green
                              : isEnded
                              ? Colors.grey
                              : Colors.orange,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          meeting.title ?? '',
                          style: sataoshiBold.copyWith(
                            fontSize: 16,
                            color: AppColors.primaryTxt,
                          ),
                        ),
                        const SizedBox(width: 8),
                        _getMeetingType(meeting),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _getSubtitleText(),
                      style: sataoshiRegular.copyWith(
                        color: Colors.grey.shade600,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),

              // Right Section: participants + button
              Row(
                children: [
                  if (meeting.participants != null &&
                      meeting.participants!.isNotEmpty)
                    OverlappedImages(
                        users:
                        meeting.participants!.map((e) => e.user!).toList()),
                  const SizedBox(width: 10),
                  _buildActionButton(isOngoing, isEnded),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getMeetingType(Meeting meeting) {
    Color bgColor;
    Color textColor;
    String label;

    switch (meeting.type) {
      case MeetingType.INSTANT:
        bgColor = Colors.blue.shade50;
        textColor = Colors.blue;
        label = "Instant";
        break;
      case MeetingType.SCHEDULED:
        bgColor = Colors.purple.shade50;
        textColor = Colors.purple;
        label = "Scheduled";
        break;
      case MeetingType.RECURRING:
        bgColor = Colors.orange.shade50;
        textColor = Colors.orange;
        label = "Recurring";
        break;
      default:
        bgColor = Colors.grey.shade200;
        textColor = Colors.grey;
        label = "";
    }

    return Container(
      margin: const EdgeInsets.only(left: 6),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: sataoshiRegular.copyWith(fontSize: 12, color: textColor),
      ),
    );
  }

  String _getSubtitleText() {
    if (meeting.status == MeetingStatus.ONGOING) {
      return "Live Now";
    } else if (meeting.status == MeetingStatus.CREATED) {
      if (meeting.startDateTime != null) {
        try {
          final start = DateTime.parse(meeting.startDateTime!);
          final now = DateTime.now();
          final difference = start.difference(now);

          if (difference.isNegative) {
            return "Starts soon";
          }

          if (difference.inDays > 0) {
            return "Starts in ${difference.inDays} day${difference.inDays > 1 ? 's' : ''}";
          } else if (difference.inHours > 0) {
            final mins = difference.inMinutes % 60;
            if (mins > 0) {
              return "Starts in ${difference.inHours} hr $mins min";
            }
            return "Starts in ${difference.inHours} hr${difference.inHours > 1 ? 's' : ''}";
          } else {
            return "Starts in ${difference.inMinutes} min${difference.inMinutes > 1 ? 's' : ''}";
          }
        } catch (_) {
          return "Starts soon";
        }
      }
      return "Starts soon";
    } else if (meeting.status == MeetingStatus.ENDED) {
      return "Ended yesterday";
    }
    return "";
  }

  Widget _buildActionButton(bool isOngoing, bool isEnded) {
    if (isOngoing) {
      return ElevatedButton(
        onPressed: () {
          // Open video call in new popup window
          VideoCallWindowHelper.openVideoCallWindow(
            meetingId: meeting.id ?? 0,
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
        child: Text(
          "Join",
          style: sataoshiMedium.copyWith(color: Colors.white, fontSize: 14),
        ),
      );
    } else {
      return OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Colors.grey.shade300),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
        child: Text(
          "Details",
          style: sataoshiMedium.copyWith(
            color: Colors.grey.shade800,
            fontSize: 14,
          ),
        ),
      );
    }
  }
}
