import 'package:projectflow_web/datasource/responses/pagination.dart';
class PaginatedListResponse<T> {
  final Pagination pagination;
  final List<T> data;

  const PaginatedListResponse({
    required this.pagination,
    required this.data,
  });

  factory PaginatedListResponse.fromJson(
      Map<String, dynamic> json,
      T Function(Map<String, dynamic>) fromJsonT,
      ) {
    return PaginatedListResponse(
      pagination: Pagination.fromJson(json['pagination']),
      data: (json['data'] as List)
          .map((item) => fromJsonT(item as Map<String, dynamic>))
          .toList(),
    );
  }
}