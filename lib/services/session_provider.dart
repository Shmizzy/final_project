import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yardex/controllers/session_controller.dart';
import 'package:yardex/models/session.dart';
import 'package:yardex/services/auth_controller_provider.dart';

final sessionProvider = StateNotifierProvider<SessionStateNotifier, UserSession>((ref) {
  final authController = ref.watch(authControllerProvider);
  return SessionStateNotifier(authController);
});
