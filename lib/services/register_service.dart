import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:senior_phone_app/constants.dart';

class RegisterService {
    final apiUrl = '${ApiConstants.baseUrl}/auth/register';


  Future<void> register(String email, String password) async {

    final response = await http.post(
       Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json',},
      body: json.encode({'email': email,'password': password}),
    );

    if (response.statusCode == 200) {
      // Registro exitoso
      return;
    } else if (response.statusCode == 409) {
      throw Exception('El correo ya está registrado');
    } else {
      throw Exception('Error al registrar el usuario');
    }
  }
}
