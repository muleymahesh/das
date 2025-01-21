class CommonResponse {
  String? message;
  String? error;

  CommonResponse({this.message, this.error});

  factory CommonResponse.fromJson(Map<String, dynamic> json) {
    return CommonResponse(
      message: json['message'],
      error: json['error'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'error': error,
    };
  }
}