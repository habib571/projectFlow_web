class AddTaskRequest {
  String? name;
  String? description;
  String? deadline;
  String? priority;
  int? assignedUserId;
  AddTaskRequest(this.name, this.description, this.deadline, this.priority,
      this.assignedUserId);
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'assignedTo': assignedUserId,
      'deadline': deadline,
      'priority': priority,
    };
  }

}