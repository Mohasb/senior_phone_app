import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'services/login_service.dart';
import 'services/register_service.dart';
import 'viewmodels/login_viewmodel.dart';
import 'viewmodels/register_viewmodel.dart';
import 'views/login_screen.dart';
import 'views/home_screen.dart';
import 'views/register_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => LoginViewModel(loginService: LoginService())),
        ChangeNotifierProvider(
            create: (_) =>
                RegisterViewModel(registerService: RegisterService())),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: '/login',
        routes: {
          '/home': (context) => const HomeScreen(),
          '/login': (context) =>  LoginScreen(),
          '/register': (context) =>  RegisterScreen(),
        },
      ),
    );
  }
}
