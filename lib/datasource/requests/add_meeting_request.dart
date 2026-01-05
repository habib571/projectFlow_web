import 'package:projectflow_web/domain/models/meeting.dart';

class AddMeetingRequest {
  final String title ;
  final MeetingType? type ;
  final int projectId ;
  final String? startDateTime ;
  final List<int> participantsIds ;
  final double duration ;

  AddMeetingRequest( {
   required this.duration,
    required this.title,
    this.type,
    required this.projectId,
    this.startDateTime,
    required this.participantsIds,
  });
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'type': type?.toString().split('.').last,
      "projectId" :projectId ,
      'scheduledTime': startDateTime,
      'participantIds': participantsIds,
       'duration': duration
    };
  }
}