import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  static const String _tokenKey = 'auth_token';

  // Credenciais locais do checkpoint
  static const String _validUsername = 'Kaue';
  static const String _validPassword = '123456789';

  // Token fake — mantém a estrutura JWT do projeto sem backend real
  static const String _fakeToken =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9'
      '.eyJ1c2VyIjoiWWFnw6NvIiwiaWF0IjoxNjAwMDAwMDAwfQ'
      '.fake_signature_checkpoint';

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // Singleton — mantém padrão do projeto
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  /// Valida localmente e persiste token fake via flutter_secure_storage.
  Future<void> login({
    required String username,
    required String password,
  }) async {
    if (username == _validUsername && password == _validPassword) {
      await _storage.write(key: _tokenKey, value: _fakeToken);
    } else {
      throw Exception('Usuário ou senha inválidos.');
    }
  }

  Future<void> logout() async {
    await _storage.delete(key: _tokenKey);
  }

  Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: _tokenKey);
    return token != null && token.isNotEmpty;
  }

  Future<String?> getToken() async {
    return _storage.read(key: _tokenKey);
  }
}
