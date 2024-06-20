import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yardex/controllers/auth_provider.dart';
import 'package:yardex/models/user.dart';

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key});

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
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
                  User user = User(
                      email: _email, username: _email, password: _password);
                  await ref.read(authNotifierProvider.notifier).login(user);
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Login successful!')));
                  context.go('/');
                }
              },
              child: const Text('Submit'))
        ],
      ),
    );
  }
}
