import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controller/auth_controller.dart';
import 'ui/pages/login.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthController())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "SIAPRAJA",
      home: const Login(),
    );
  }
}
