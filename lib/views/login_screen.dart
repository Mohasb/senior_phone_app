import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_phone_app/utils/app_localizations.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import '../viewmodels/login_viewmodel.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final Function(String) onNavigate;

  LoginScreen({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<LoginViewModel>(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(
              hintText: AppLocalizations.of(context)!.translate('Email'),
              controller: viewModel.emailController,
              validator: (value) => viewModel.validateEmail(value, context),
            ),
            const SizedBox(height: 10),
            CustomTextField(
              hintText: AppLocalizations.of(context)!.translate('Password'),
              obscureText: true,
              controller: viewModel.passwordController,
              validator: (value) => viewModel.validatePassword(value, context),
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: AppLocalizations.of(context)!.translate('login'),
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  viewModel.login(context);
                }
              },
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                // Aquí llamas a onNavigate para redirigir al home después del login
                onNavigate('/home');
              },
              child: Text(AppLocalizations.of(context)!.translate('noAccount')),
            ),
            const SizedBox(height: 20),
            Text(AppLocalizations.of(context)!.translate('orOauth')),
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
    );
  }
}
