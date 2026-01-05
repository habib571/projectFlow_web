enum NotificationType {
  MEMBER_JOINED_PROJECT,
  New_Task_Assigned ,
  PROJECT_UPDATED,
  New_MEETING_SCHEDULED;

  static NotificationType fromString(String value) {
    return NotificationType.values.firstWhere(
      (e) => e.name == value,
      orElse: () => NotificationType.PROJECT_UPDATED,
    );
  }
}
