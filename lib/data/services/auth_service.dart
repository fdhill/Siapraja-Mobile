// lib/data/services/auth_service.dart
import '../../core/network/api_client.dart';

class AuthService {
  final ApiClient _apiClient = ApiClient();

  Future<bool> loginProcess(String user, String pass) async {
    // Tinggal panggil, sangat bersih!
    final response = await _apiClient.post("/auth/login", {
      "username": user,
      "password": pass
    });

    return response.statusCode == 200;
  }
}