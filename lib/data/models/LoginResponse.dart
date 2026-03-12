class LoginResponse {
  final bool status;
  final String? token;
  final String? message;

  LoginResponse({required this.status, this.token, this.message});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: json['status'] ?? false,
      token: json['payload']?['token'], // Sesuaikan dengan struktur JSON Spring Boot Anda
      message: (json['message'] as List?)?.first ?? "",
    );
  }
}