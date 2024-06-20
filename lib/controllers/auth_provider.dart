import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:yardex/models/session.dart';
import 'package:yardex/models/user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_provider.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  final String _authUrl = 'http://10.0.2.2:3000/auth';
  final _storage = FlutterSecureStorage();

  @override
  UserSession build() {
    return UserSession();
  }

  Future<void> register(User user) async {
    try {
      final res = await http.post(Uri.parse('$_authUrl/register'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(user.toJson()));
      final data = jsonDecode(res.body);
      if (res.statusCode == 201) {
        String token = data['token'];
        String id = data['id'];
        await _storage.write(key: 'jwt_token', value: token);
        await _storage.write(key: 'id', value: id);
        state = UserSession(token: token, id: id);
      } else
        print('Failed to create user: ${res.body}');
    } catch (e) {
      throw Exception('Error trying to register... $e');
    }
  }

  Future<void> login(User user) async {
    try {
      final res = await http.post(
        Uri.parse('$_authUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': user.email, 'password': user.password}),
      );
      final data = jsonDecode(res.body);
      if (res.statusCode == 201) {
        String token = data['token'];
        String id = data['id'];
        await _storage.write(key: 'jwt_token', value: token);
        await _storage.write(key: 'id', value: id);
        state = UserSession(token: token, id: id);
      } else
        print('Failed to create user: ${res.body}');
    } catch (e) {
      throw Exception('Error trying to register... $e');
    }
  }

  Future<void> signOut() async {
    await _storage.delete(key: 'jwt_token');
    await _storage.delete(key: 'id');
    state = UserSession(token: null, id: null);
  }

  
}
