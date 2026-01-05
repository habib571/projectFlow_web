import 'package:projectflow_web/domain/models/notification_type.dart';

class NotificationModel {
  final int id;
  final String title;
  final Map<String, dynamic> body;
  final DateTime sentAt;
  final bool read;

  const NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.sentAt,
    required this.read,
  });

  /// Extracts notification type from title
  NotificationType get type {
    return NotificationType.fromString(title);
  }

  /// Helper getters for body fields based on notification type
  String? get actorName => body['actorName'] as String?;
  String? get actorImage => body['actorImage'] as String?;
  String? get projectName => body['projectName'] as String?;
  String? get taskName => body['taskName'] as String?;
  String? get taskPriority => body['taskPriority'] as String?;
  String? get meetingName => body['meetingName'] as String?;
  String? get meetingDate => body['meetingDate'] as String?;

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] as int,
      title: json['title'] as String? ?? '',
      body: json['body'] as Map<String, dynamic>? ?? {},
      sentAt: json['sentAt'] != null
          ? DateTime.parse(json['sentAt'] as String)
          : DateTime.now(),
      read: json['read'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'sentAt': sentAt.toIso8601String(),
      'read': read,
    };
  }
}
