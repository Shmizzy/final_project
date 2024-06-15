import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yardex/controllers/auth_controller.dart';
import 'package:yardex/models/session.dart';

class SessionStateNotifier extends StateNotifier<UserSession> {
  final AuthController _authController;

  SessionStateNotifier(this._authController) : super(UserSession(token: null)) {
    _init();
  }
  void _init() async {
    final token = await _authController.getToken();
    if (token != null) {
      state = UserSession(token: token);
    }
  }

  Future<void> login(String email, String password) async {
    final result = await _authController.login(email, password);
    if(result['success'] == true){
      state = UserSession(token: result['user']['token']);
    }
  }
  void updateSession(String? token) {
    state = UserSession(token: token);
  }
}

