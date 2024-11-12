import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:senior_phone_app/constants.dart';

class LoginService {
  final apiUrl = '${ApiConstants.baseUrl}/auth/login';
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  Future<String> login(String email, String password) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final token = responseData['data']['token'];

      // Guarda el token en almacenamiento seguro
      await secureStorage.write(key: 'auth_token', value: token);

      return token;
    } else {
      final errorData = json.decode(response.body);
      throw errorData['message'] ?? 'Error desconocido';
    }
  }

  Future<void> logout() async {
    // Elimina el token al cerrar sesión
    await secureStorage.delete(key: 'auth_token');
  }

  Future<String?> getToken() async {
    // Recupera el token si está disponible
    return await secureStorage.read(key: 'auth_token');
  }
}
