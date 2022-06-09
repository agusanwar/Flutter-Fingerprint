import 'package:flutter/material.dart';

class BiometricScreen extends StatefulWidget {
  const BiometricScreen({Key? key}) : super(key: key);

  @override
  State<BiometricScreen> createState() => _BiometricScreenState();
}

class _BiometricScreenState extends State<BiometricScreen> {
  bool isAvailable = false;
  bool isAuthenticated = false;
  final String text = "Please check Boimetric Avaibality";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Biometric Authenticted')),
    );
  }
}
