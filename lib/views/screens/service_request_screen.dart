import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yardex/views/widgets/service_request_form.dart';

class ServiceRequestScreen extends StatelessWidget {
  const ServiceRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request Service'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            context.go('/');
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Center(
        child: ServiceRequestForm(),
      ),
    );
  }
}
