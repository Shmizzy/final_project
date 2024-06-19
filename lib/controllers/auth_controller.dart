import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:yardex/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:yardex/providers/session_provider.dart';

class AuthController {
  GlobalKey<FormState> formKey;

  User user = User(username: '', email: '', password: '');
  final ProviderRef ref;
  AuthController(this.formKey, this.ref);

  final _storage = FlutterSecureStorage();

  Future<Map<String, dynamic>?> register(email, password) async {
    user = User(username: email, email: email, password: password);
    try {
      final res = await http.post(
          Uri.parse('http://10.0.2.2:3000/auth/register'),
          headers: <String, String>{'Content-type': 'application/json'},
          body: jsonEncode(user.toJson()));
      final data = jsonDecode(res.body);
      if (res.statusCode == 201) {
        String token = data['token'];
        print(token);
        await _storage.write(key: 'jwt_token', value: token);
        ref.read(sessionProvider.notifier).updateSession(token);
        return {'success': true, 'user': data};
      } else
        return {
          'success': false,
          'message': 'Registration failed: ${res.body}'
        };
    } catch (e) {
      print(e.toString());
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final res = await http.post(
        Uri.parse('http://10.0.2.2:3000/auth/login'),
        headers: <String, String>{'Content-type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );
      final data = jsonDecode(res.body);
      if (res.statusCode == 201) {
        String token = data['token'];
        await _storage.write(key: 'jwt_token', value: token);
        ref.read(sessionProvider.notifier).updateSession(token);
        return {'success': true, 'user': data};
      } else
        return {'success': false, 'message': 'Login failed: ${res.body}'};
    } catch (e) {
      print(e.toString());
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<String?> getToken() async {
    return await _storage.read(key: 'jwt_token');
  }

  Future<void> destroyToken() async {
    await _storage.delete(key: 'jwt_token');
    ref.read(sessionProvider.notifier).updateSession(null);
  }
}
