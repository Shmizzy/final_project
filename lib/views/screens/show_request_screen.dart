import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yardex/controllers/service_request_provider.dart';

class ShowRequestScreen extends ConsumerWidget {
  const ShowRequestScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final serviceRequest = ref.watch(serviceRequestNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Request Service'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            context.go('/');
          },
          icon: Icon(Icons.exit_to_app),
        ),
      ),
      body: serviceRequest != null ? Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
          ],
        ),
      ) : Center(child: Text('No request details available')),
    );
  }
}