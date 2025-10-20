import 'package:projectflow_web/domain/models/project_model.dart';
import 'package:projectflow_web/domain/models/user_model.dart';

class MemberModel {
  final int? id ;
  final UserModel? user ;
  final ProjectModel? project ;
  final String? role ;
  final String? joinedAt ;

  MemberModel(this.id, this.user, this.project, this.role, this.joinedAt);
}