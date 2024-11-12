import 'dart:developer';

import 'package:flutter/material.dart';
import '../services/login_service.dart';
import '../utils/app_localizations.dart';

class LoginViewModel with ChangeNotifier {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final LoginService loginService;

  LoginViewModel({required this.loginService});

  Future<void> login(BuildContext context) async {
    final email = emailController.text.trim();
    final password = passwordController.text;

    try {
      // Llama al servicio de autenticación y guarda el token
      /* final token = */ await loginService.login(email, password);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.translate('okLogin'))),
        );

        // Navegación a otra pantalla
        Navigator.pushReplacementNamed(context, '/home');
      }
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error de autenticación: $error")),
        );
      }
      log('error: $error');
    }
  }

  Future<void> logout(BuildContext context) async {
    await loginService.logout();
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Cierre de sesión exitoso")),
      );
      // Redirige a la pantalla de login
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  Future<String?> getStoredToken() async {
    return await loginService.getToken();
  }

  String? validateEmail(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.translate('emptyEmail');
    }
    if (!RegExp(r'^[\w-]+@([\w-]+\.)+[\w-]{2,4}').hasMatch(value)) {
      return AppLocalizations.of(context)!.translate('invalidEmail');
    }
    return null;
  }

  String? validatePassword(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.translate('emptyPassword');
    } else if (value.length < 6) {
      return 'La contraseña debe tener al menos 6 caracteres';
    }
    return null;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
