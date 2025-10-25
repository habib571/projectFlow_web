import 'package:projectflow_web/domain/models/project_model.dart';
import 'package:projectflow_web/domain/models/user_model.dart';

class MemberModel {
  final int? id;
  final UserModel? user;
  final ProjectModel? project;
  final String? role;
  final String? joinedAt;

  MemberModel(this.id, this.user, this.project, this.role, this.joinedAt);

  factory MemberModel.fromJson(Map<String, dynamic> json) {
    return MemberModel(
      json['id'] as int?,
      json['user'] != null ? UserModel.fromJson(json['user']) : null,
      json['project'] != null ? ProjectModel.fromJson(json['project']) : null,
      json['role'] as String?,
      json['joinedAt'] as String?,
    );
  }
}
