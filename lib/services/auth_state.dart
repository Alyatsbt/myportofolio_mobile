import 'package:flutter/foundation.dart';
import 'package:myportofolio_mobile/services/api_client.dart';

class AuthState extends ChangeNotifier {
  AuthState(this._apiClient, {String? initialToken}) : _token = initialToken;

  final ApiClient _apiClient;
  String? _token;

  String? get token => _token;
  bool get isLoggedIn => _token != null;

  Future<void> login(String username, String password) async {
    final token = await _apiClient.obtainToken(username, password);
    _token = token;
    notifyListeners();
  }

  Future<void> logout() async {
    final token = _token;
    if (token == null) return;
    try {
      await _apiClient.logout(token: token);
    } finally {
      _token = null;
      notifyListeners();
    }
  }
}
