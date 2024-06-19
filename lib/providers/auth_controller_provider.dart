import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yardex/controllers/auth_controller.dart';

final authControllerProvider = Provider<AuthController>((ref) {
  
  return AuthController(GlobalKey<FormState>(), ref);
});