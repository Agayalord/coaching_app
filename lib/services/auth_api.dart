import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthApi {
  final String baseUrl;

  AuthApi(this.baseUrl);

  Future<int> login(String email, String password) async {
    final res = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (res.statusCode != 200) {
      throw Exception('Login failed');
    }

    return jsonDecode(res.body)['user_id'];
  }

  Future<int> register(String email, String password, String? name) async {
    final res = await http.post(
      Uri.parse('$baseUrl/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
        'full_name': name,
      }),
    );

    if (res.statusCode != 200) {
      throw Exception('Registration failed');
    }

    return jsonDecode(res.body)['user_id'];
  }
}
