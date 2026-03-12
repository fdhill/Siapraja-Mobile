import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controller/auth_controller.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController usernameInput = TextEditingController();
  final TextEditingController passwordInput = TextEditingController();

  void handleLogin(AuthController authController) async {
    print("Mencoba login untuk: ${usernameInput.text}"); // Cek di console

    if (usernameInput.text.isEmpty || passwordInput.text.isEmpty) {
      _showFeedback(message: "Username & Password kosong!", isSuccess: false);
      return;
    }

    try {
      bool success = await authController.login(
        usernameInput.text,
        passwordInput.text,
      );

      if (success) {
        print("Login Berhasil!");
        _showFeedback(
          message: "Login Berhasil! Selamat datang ${usernameInput.text}",
          isSuccess: true,
        );
        // Sesuai permintaan: Tidak ada navigasi (pindah halaman) di sini
      } else {
        print("Login Gagal: Response bukan 200");
        _showFeedback(
          message: "Login Gagal! Akun salah atau masalah server.",
          isSuccess: false,
        );
      }
    } catch (e) {
      print("Error terdeteksi: $e");
      _showFeedback(
        message: "Terjadi kesalahan koneksi ke server.",
        isSuccess: false,
      );
    }
  }

  void _showFeedback({required String message, required bool isSuccess}) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar(); // Tutup snackbar lama jika ada
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isSuccess ? Colors.green : Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Pastikan Provider sudah terpasang di main.dart
    final authController = Provider.of<AuthController>(context);

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "SIAPRAJA",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.blue),
              ),
              const SizedBox(height: 30),
              _buildTextField(usernameInput, "Username", false),
              const SizedBox(height: 15),
              _buildTextField(passwordInput, "Password", true),
              const SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: authController.isLoading 
                      ? null 
                      : () => handleLogin(authController),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: authController.isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3),
                        )
                      : const Text("Login", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint, bool obscure) {
    return Container(
      decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(15),
        ),
      ),
    );
  }
}