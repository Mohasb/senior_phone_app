import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'services/login_service.dart';
import 'services/register_service.dart';
import 'utils/app_localizations.dart';
import 'viewmodels/login_viewmodel.dart';
import 'viewmodels/register_viewmodel.dart';
import 'views/login_screen.dart';
import 'views/home_screen.dart';
import 'views/register_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('en', 'US'); // Idioma por defecto
  String _currentRoute = '/login'; // Ruta inicial

  void _changeLocale(Locale newLocale) {
    setState(() {
      _locale = newLocale;
    });
  }

  void _navigateTo(String route) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _currentRoute = route;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => LoginViewModel(loginService: LoginService())),
        ChangeNotifierProvider(
            create: (_) => RegisterViewModel(registerService: RegisterService())),
      ],
      child: MaterialApp(
        locale: _locale,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('es', 'ES'),
        ],
        home: Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)?.translate('app_title') ?? 'Senior Phone App'),
            actions: [
              Builder(
                builder: (context) => DropdownButton<Locale>(
                  underline: const SizedBox(),
                  icon: const Icon(Icons.language, color: Colors.black),
                  onChanged: (Locale? newLocale) {
                    if (newLocale != null) {
                      _changeLocale(newLocale);
                    }
                  },
                  items: const [
                    DropdownMenuItem(
                      value: Locale('en', 'US'),
                      child: Text('English'),
                    ),
                    DropdownMenuItem(
                      value: Locale('es', 'ES'),
                      child: Text('Español'),
                    ),
                  ],
                ),
              ),
            ],
          ),
          body: Builder(
            builder: (context) {
              switch (_currentRoute) {
                case '/login':
                  return LoginScreen(onNavigate: _navigateTo);
                case '/register':
                  return RegisterScreen(onNavigate: _navigateTo);
                case '/home':
                  return const HomeScreen();
                default:
                  return LoginScreen(onNavigate: _navigateTo);
              }
            },
          ),
        ),
      ),
    );
  }
}
