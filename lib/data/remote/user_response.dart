class UserResponse {
  final int id;
  final String name;
  final String username;
  final String mobile;
  final String password;
  final String role;
  final String region;
  final String supervisorName;
  final String collection;
  final String commission;

  UserResponse({
    required this.id,
    required this.name,
    required this.username,
    required this.mobile,
    required this.password,
    required this.role,
    required this.region,
    required this.supervisorName,
    required this.collection,
    required this.commission,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      id: int.parse(json['user_id']),
      name: json['name'],
      username: json['username'],
      mobile: json['mobile'],
      password: json['password'],
      role: json['role'],
      region: json['region'],
      supervisorName: json['supervisor_name'],
      collection: json['collection'],
      commission: json['commission'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': id.toString(),
      'name': name,
      'username': username,
      'mobile': mobile,
      'password': password,
      'role': role,
      'region': region,
      'supervisor_name': supervisorName,
      'collection': collection,
      'commission': commission,
    };
  }
}