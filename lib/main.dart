import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yardex/providers/session_provider.dart';
import 'package:yardex/views/screens/auth_screen.dart';
import 'package:yardex/views/screens/home_screen.dart';
import 'package:yardex/views/screens/login_screen.dart';
import 'package:yardex/views/screens/register_screen.dart';

void main() {
  runApp(ProviderScope(child: YardexApp()));
}

class YardexApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(sessionProvider);

    final _router = GoRouter(routes: [
      GoRoute(
          path: '/',
          builder: (context, state) =>
              session.token == null ? AuthScreen() : HomeScreen()),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(
          path: '/register',
          builder: (context, state) => const RegisterScreen()),
    ]);

    return MaterialApp.router(
      title: 'Yardex',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      routerConfig: _router,
    );
  }
}
