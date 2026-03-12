import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiClient {
  // 1. Alamat Pusat Server Spring Boot
  // Gunakan 10.0.2.2 untuk emulator Android
  static const String baseUrl = "http://10.0.2.2:8080/api";
  
  final _storage = const FlutterSecureStorage();

  // 2. Fungsi untuk menyusun Header otomatis
  // Fungsi ini akan mengecek apakah ada token tersimpan, jika ada langsung dimasukkan
  Future<Map<String, String>> _getHeaders() async {
    String? token = await _storage.read(key: 'jwt_token');
    
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  // 3. Fungsi POST (Dipakai untuk Login, Simpan Data, dll)
  Future<http.Response> post(String endpoint, Map<String, dynamic> body) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final headers = await _getHeaders();
    
    return await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );
  }

  // 4. Fungsi GET (Dipakai untuk Ambil Data)
  Future<http.Response> get(String endpoint) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final headers = await _getHeaders();
    
    return await http.get(url, headers: headers);
  }
}