import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../../domain/models/meeting.dart';
import '../../../../theme/colors.dart';
import '../../../../theme/styles.dart';

class UpNextCard extends StatelessWidget {
  final List<Meeting> meetings;
  final bool isLoading;

  const UpNextCard({super.key, required this.meetings, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    final scheduledMeetings = meetings
        .where((m) => m.type == MeetingType.SCHEDULED && m.startDateTime != null)
        .toList();

    // Sort by startDateTime
    scheduledMeetings.sort((a, b) {
      try {
        final aDate = DateTime.parse(a.startDateTime!);
        final bDate = DateTime.parse(b.startDateTime!);
        return aDate.compareTo(bDate);
      } catch (e) {
        return 0;
      }
    });

    // Filter for scheduled meetings that are not ended
    var upcomingMeetings = scheduledMeetings
        .where((m) => m.status != MeetingStatus.ENDED)
        .take(3)
        .toList();

    // If loading and we have no meetings yet, show 3 skeletons
    if (isLoading && upcomingMeetings.isEmpty) {
      upcomingMeetings = List.generate(3, (index) => Meeting(
        title: "Meeting Title Placeholder",
        type: MeetingType.SCHEDULED,
        startDateTime: DateTime.now().add(Duration(hours: index + 1)).toIso8601String(),
      ));
    }

    return Skeletonizer(
      enabled: isLoading,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Up Next",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            if (upcomingMeetings.isEmpty && !isLoading)
              const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    "No upcoming meetings",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              )
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: upcomingMeetings.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final meeting = upcomingMeetings[index];
                  DateTime? dt;
                  try {
                    dt = DateTime.parse(meeting.startDateTime!);
                  } catch (_) {}

                  return _upNextItem(
                    date: dt != null ? DateFormat('MMM dd').format(dt).toUpperCase() : "N/A",
                    title: meeting.title ?? "Meeting",
                    time: dt != null ? DateFormat('hh:mm a').format(dt) : "N/A",
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _upNextItem({
    required String date,
    required String title,
    required String time,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 48,
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Text(
                date.substring(0, 3),
                textAlign: TextAlign.center,
                style:  sataoshiBold.copyWith(color: Colors.red.shade300 , fontSize: 16)
              ) ,
              Text(
                date.substring(3),
                textAlign: TextAlign.center,
                style: sataoshiBold.copyWith(fontSize: 20)
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                time,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
