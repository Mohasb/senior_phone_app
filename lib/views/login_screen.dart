import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import '../viewmodels/login_viewmodel.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<LoginViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextField(
                hintText: "Email",
                controller: viewModel.emailController,
                validator: viewModel.validateEmail,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                hintText: "Contraseña",
                obscureText: true,
                controller: viewModel.passwordController,
                validator: viewModel.validatePassword,
              ),
              const SizedBox(height: 20),
              CustomButton(
                text: "Iniciar Sesión",
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    viewModel.login(context);
                  }
                },
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: const Text("No tienes cuenta? Regístrate aquí"),
              ),
              const SizedBox(height: 20),
              const Text("O inicia sesión con"),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    icon: Icons.g_mobiledata,
                    text: "Google",
                    onPressed: () {
                      // lógica para el inicio de sesión con Google
                    },
                  ),
                  const SizedBox(width: 10),
                  CustomButton(
                    icon: Icons.apple,
                    text: "Apple",
                    onPressed: () {
                      // lógica para el inicio de sesión con Apple
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
