import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:myportofolio_mobile/config.dart';
import 'package:myportofolio_mobile/models/project.dart';

class ApiException implements Exception {
  const ApiException(this.statusCode, this.message);

  final int statusCode;
  final String message;

  @override
  String toString() => 'ApiException($statusCode): $message';
}

class ApiClient {
  ApiClient({http.Client? client, this.baseUrl = apiBaseUrl})
    : _client = client ?? http.Client();

  final http.Client _client;
  final String baseUrl;

  Uri _uri(String path) => Uri.parse(baseUrl).resolve(path);

  void _validate(http.Response response) {
    if (response.statusCode < 200 || response.statusCode >= 300) {
      final message = switch (response.statusCode) {
        400 => 'Data yang dikirim tidak valid.',
        401 => 'Autentikasi gagal atau sesi telah berakhir.',
        403 =>
          'Akun ini tidak memiliki izin untuk melakukan tindakan tersebut.',
        _ => 'Permintaan gagal. Silakan coba lagi.',
      };
      throw ApiException(response.statusCode, message);
    }
  }

  Map<String, String> get _jsonHeaders => const {
    'Accept': 'application/json',
    'Content-Type': 'application/json; charset=UTF-8',
  };

  Future<List<Project>> getProjects() async {
    final response = await _client.get(
      _uri('/api/v1/projects/'),
      headers: const {'Accept': 'application/json'},
    );
    _validate(response);
    final decoded = jsonDecode(response.body);
    final List<dynamic> rows = switch (decoded) {
      List<dynamic> list => list,
      Map<String, dynamic> map when map['results'] is List =>
        map['results'] as List<dynamic>,
      _ => throw const FormatException('Format daftar project tidak dikenali.'),
    };
    return rows
        .map((row) => Project.fromJson(row as Map<String, dynamic>))
        .toList(growable: false);
  }

  Future<Project> createProject(
    Project project, {
    required String token,
  }) async {
    final response = await _client.post(
      _uri('/api/v1/projects/'),
      headers: {..._jsonHeaders, 'Authorization': 'Token $token'},
      body: jsonEncode(project.toJson()),
    );
    _validate(response);
    return Project.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  }

  Future<String> obtainToken(String username, String password) async {
    final response = await _client.post(
      _uri('/api/v1/auth/token/'),
      headers: _jsonHeaders,
      body: jsonEncode({'username': username, 'password': password}),
    );
    _validate(response);
    final body = jsonDecode(response.body) as Map<String, dynamic>;
    final token = body['token'];
    if (token is! String || token.isEmpty) {
      throw const FormatException('Respons login tidak berisi token.');
    }
    return token;
  }

  Future<void> logout({required String token}) async {
    final response = await _client.post(
      _uri('/api/v1/auth/logout/'),
      headers: {'Accept': 'application/json', 'Authorization': 'Token $token'},
    );
    _validate(response);
  }

  void close() => _client.close();
}
