import 'package:flutter/material.dart';
import 'package:yardex/views/widgets/new_register_form.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Center(child: RegisterForm()),
    );
  }
}
