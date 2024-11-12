import 'package:flutter/material.dart';
import '../services/register_service.dart';

class RegisterViewModel with ChangeNotifier {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final RegisterService registerService;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  RegisterViewModel({required this.registerService});

  Future<void> register(BuildContext context) async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Por favor ingrese todos los campos")),
      );
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      await registerService.register(email, password);

      if (context.mounted) {
        // Si el registro es exitoso
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Registro exitoso")),
        );

        Navigator.pushReplacementNamed(context, '/home');
      }
    } catch (error) {
      if (context.mounted) {
        // Manejo de error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: $error")),
        );
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
