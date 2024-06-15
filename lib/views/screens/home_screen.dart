import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yardex/services/auth_controller_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Yardex Welcome')),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await ref.read(authControllerProvider).destroyToken();
            context.go('/');
          },
          child: Text('Logout'),
        ),
      ),
    );
  }
}
