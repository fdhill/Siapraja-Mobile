// lib/data/services/auth_service.dart
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../core/network/api_client.dart';
import '../../data/models/login_response.dart';

class AuthService {
  final ApiClient _apiClient = ApiClient();
  final _storage = const FlutterSecureStorage();

  Future<LoginResponse> loginProcess(String user, String pass) async {
    try {
      final response = await _apiClient.post("/auth/login", {
        "username": user,
        "password": pass
      });

      final Map<String, dynamic> responseData = jsonDecode(response.body);

      final loginResponse = LoginResponse.fromJson(responseData);

      if (loginResponse.status && loginResponse.token != null) {
        await _storage.write(key: 'jwt_token', value: loginResponse.token);
      }

      return loginResponse;
    } catch (e) {
      return LoginResponse(status: false, message: "Gagal terhubung ke server");
    }
  }
}