class UserModel {
  final int? id;
  final String? fullName;
  final String? email;
  final String? imageUrl;

  const UserModel({
    this.id,
    this.fullName,
    this.email,
    this.imageUrl,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      fullName: json['fullName'] ,
      email: json['email'] ,
      imageUrl: json['imageUrl'] ?? "",
    );
  }
}
