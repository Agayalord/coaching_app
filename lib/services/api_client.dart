import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  ApiClient({required this.baseUrl});

  /// Example for Android emulator: http://10.0.2.2:8000
  final String baseUrl;

  Uri _uri(String path, [Map<String, String>? query]) {
    final cleanedBase = baseUrl.endsWith('/')
        ? baseUrl.substring(0, baseUrl.length - 1)
        : baseUrl;
    final cleanedPath = path.startsWith('/') ? path : '/$path';
    return Uri.parse(
      '$cleanedBase$cleanedPath',
    ).replace(queryParameters: query);
  }

  Future<Map<String, dynamic>> getJson(
    String path, {
    Map<String, String>? query,
  }) async {
    final res = await http.get(
      _uri(path, query),
      headers: {'Accept': 'application/json'},
    );
    _throwIfNotOk(res);
    return jsonDecode(res.body) as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> postJson(
    String path, {
    required Map<String, dynamic> body,
  }) async {
    final res = await http.post(
      _uri(path),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );
    _throwIfNotOk(res);
    return jsonDecode(res.body) as Map<String, dynamic>;
  }

  void _throwIfNotOk(http.Response res) {
    if (res.statusCode >= 200 && res.statusCode < 300) return;
    final message = 'HTTP ${res.statusCode}: ${res.body}';
    throw Exception(message);
  }
}
