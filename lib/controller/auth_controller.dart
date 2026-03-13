import 'package:flutter/material.dart';
import '../data/services/auth_service.dart';
import '../data/models/login_response.dart';

class AuthController extends ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<LoginResponse> login(String username, String password) async {
    _isLoading = true;
    notifyListeners();

    LoginResponse result = await _authService.loginProcess(username, password);

    _isLoading = false;
    notifyListeners();

    return result;
  }
}