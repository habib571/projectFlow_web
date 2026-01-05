class DeviceTokenResponse {
  final String status;
  final String message;

  DeviceTokenResponse({required this.status, required this.message});

  factory DeviceTokenResponse.fromJson(Map<String, dynamic> json) {
    return DeviceTokenResponse(
      status: json['status'] as String,
      message: json['message'] as String,
    );
  }
}
