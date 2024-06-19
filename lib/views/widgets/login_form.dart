import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yardex/controllers/auth_controller.dart';
import 'package:yardex/providers/auth_controller_provider.dart';

class LoginForm extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();
  late AuthController _authController;
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _authController = ref.read(authControllerProvider);

    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) return 'Please enter a valid email.';
              return null;
            },
            onSaved: (value) => _email = value!,
          ),
          TextFormField(
            validator: (value) {
              if (value!.isEmpty || value.length < 6)
                return 'Password must be at least 6 characters';
              return null;
            },
            onSaved: (value) => _password = value!,
            obscureText: true,
          ),
          ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  final res = await _authController.login(_email, _password);
                  if (res['success'] == true) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Login successful!')));
                    context.go('/');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(res['message'] ?? 'Login Failed')));
                  }
                }
              },
              child: const Text('Submit'))
        ],
      ),
    );
  }
}
