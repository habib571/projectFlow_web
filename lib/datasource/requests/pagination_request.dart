class PaginationRequest {
  final int? page;
  final int? size;

  PaginationRequest(this.page, this.size);

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'size': size,
    };
  }
}
