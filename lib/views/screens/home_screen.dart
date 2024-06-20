import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yardex/controllers/auth_provider.dart';
import 'package:yardex/views/widgets/map.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yardex Welcome'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          const YardexMap(),
          Positioned(
            top: MediaQuery.of(context).padding.top,
            right: 0,
            left: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: () async {
                  await ref.read(authNotifierProvider.notifier).signOut();
                  context.go('/');
                },
                child: Text('Logout'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
