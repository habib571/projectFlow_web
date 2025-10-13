import 'package:equatable/equatable.dart';
import 'package:projectflow_web/domain/models/user_model.dart';

class ProjectModel extends Equatable {
  final int? id;
  final String? title;
  final String? description;
  final String? dueDate;
  final double? progress;
  final UserModel? createdBy; // made nullable

  const ProjectModel({
    this.id,
    this.title,
    this.description,
    this.dueDate,
    this.progress,
    this.createdBy,
  });

  const ProjectModel.request({
    required this.title,
    required this.description,
  })  : id = null,
        dueDate = null,
        progress = null,
        createdBy = null;

  factory ProjectModel.fromJson(Map<String, dynamic> json) => ProjectModel(
    id: json['id'] as int?,
    title: json['title'] as String?,
    description: json['description'] as String?,
    dueDate: json['dueDate'] as String?,
    progress: (json['progress'] as num?)?.toDouble(),
    createdBy: json['createdBy'] != null
        ? UserModel.fromJson(json['createdBy'])
        : null,
  );

  Map<String, dynamic> toJson() => {
    'title': title,
    'description': description,
  };

  @override
  List<Object?> get props => [id, title, description, dueDate, progress, createdBy];
}
