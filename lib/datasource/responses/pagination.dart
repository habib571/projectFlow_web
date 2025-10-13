class Pagination {
  final int totalPages;
  final int pageSize;
  final int totalElements;
  final int currentPage;
  final bool isFirstPage;
  final bool isLastPage;

  Pagination({
    required this.totalPages,
    required this.pageSize,
    required this.totalElements,
    required this.currentPage,
    required this.isFirstPage,
    required this.isLastPage,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      totalPages: json['totalPages'] ?? 0,
      pageSize: json['pageSize'] ?? 0,
      totalElements: json['totalElements'] ?? 0,
      currentPage: json['currentPage'] ?? 0,
      isFirstPage: json['isFirstPage'] ?? false,
      isLastPage: json['isLastPage'] ?? false,
    );
  }
  
}
