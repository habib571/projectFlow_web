import 'package:projectflow_web/datasource/responses/pagination.dart';
import 'package:projectflow_web/domain/models/user_model.dart';

class UsersResponse {
  final Pagination pagination;
  final List<UserModel> data;
  const UsersResponse({
    required this.pagination,
    required this.data,
  });
  factory UsersResponse.fromJson(Map<String, dynamic> json) {
    return UsersResponse(
      pagination: Pagination.fromJson(json['pagination']),
      data: (json['data'] as List<dynamic>)
          .map((item) => UserModel.fromJson(item))
          .toList(),
    );
  }
}
