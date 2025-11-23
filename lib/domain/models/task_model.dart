

import 'package:projectflow_web/domain/models/project_model.dart';
import 'package:projectflow_web/domain/models/user_model.dart';

class TaskModel {
  int? id;
  String? name;
  String? description;
  String? deadline;
  String? priority;
  String? status ;
  UserModel? assignedUser;
  int? assignedUserId;
  ProjectModel? project ;

  TaskModel(this.id, this.name, this.description, this.deadline, this.priority, this.assignedUser ,this.status,this.project);

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      json['id'] ,
      json['title'] ,
      json['description'],
      json['deadline'] ,
      json['priority'] ,
      json['assignedUser'] != null ? UserModel.fromJson(json['assignedUser']) : null ,
      json['status'],
      json['project' ]!= null ? ProjectModel.fromJson(json['project']) : null ,

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'assignedTo': assignedUserId,
      'deadline': deadline,
      'priority': priority,
    };
  }

  Map<String, dynamic> updateToJson() {
    return {
      'name': name,
      'description': description,
      'assignedTo': assignedUserId,
      'deadline': deadline,
      'priority': priority,
      'status':status
    };
  }



}



