class AuthRequest {
  String? fullName;
  String? email ;
  String? password ;

  AuthRequest.register(this.fullName, this.email, this.password);
  AuthRequest.login(this.email, this.password);

  Map<String, dynamic> toJsonRegister() {
    return {
      'fullName': fullName,
      'email': email,
      'password': password,
    };
  }

  Map<String, dynamic> toJsonLogin() {
    return {
      'email': email,
      'password': password,
    };
  }
}
