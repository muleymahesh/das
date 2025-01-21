
class LoginRequest {
  String username;
  String password;
  String method = "login";
  LoginRequest({required this.username, required this.password, required this.method});
  Map<String, dynamic> toJson() => {
    'username': username,
    'password': password,
    'method': method
  };
}