import 'package:flutter/material.dart';
import '../data/services/auth_service.dart';

class AuthController extends ChangeNotifier {
  // 1. Inisialisasi Service
  final AuthService _authService = AuthService();

  // 2. State untuk Loading
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // 3. Fungsi Utama Login
  Future<bool> login(String username, String password) async {
    _isLoading = true;
    notifyListeners(); // Mengabari UI bahwa status loading berubah jadi TRUE

    try {
      // Memanggil fungsi login di Service
      bool isSuccess = await _authService.loginProcess(username, password);
      
      _isLoading = false;
      notifyListeners(); // Mengabari UI bahwa status loading kembali FALSE
      
      return isSuccess;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      print("Error di Controller: $e");
      return false;
    }
  }
}