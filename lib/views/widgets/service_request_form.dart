import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yardex/controllers/auth_provider.dart';
import 'package:yardex/controllers/service_request_provider.dart';
import 'package:yardex/controllers/servicer_provider.dart';
import 'package:yardex/models/service_request.dart';

class ServiceRequestForm extends ConsumerStatefulWidget {
  const ServiceRequestForm({super.key});

  @override
  ConsumerState<ServiceRequestForm> createState() => _ServiceRequestFormState();
}

class _ServiceRequestFormState extends ConsumerState<ServiceRequestForm> {
  final _formKey = GlobalKey<FormState>();
  String? _serviceType;
  String? _address;

  @override
  Widget build(BuildContext context) {
    final selectedServicer = ref.watch(servicerNotifierProvider);
    return Form(
        key: _formKey,
        child: Column(
          children: [
            DropdownButtonFormField(
              items: selectedServicer!.servicesOffered.map((service) {
                return DropdownMenuItem(value: service, child: Text(service));
              }).toList(),
              onChanged: (value) {
                _serviceType = value as String?;
              },
              validator: (value) =>
                  value == null ? 'Please select service type' : null,
            ),
            TextFormField(
              decoration: InputDecoration(
                  labelText: 'Address', hintText: 'Enter your address'),
              validator: (value) =>
                  value == null || value.isEmpty ? 'Address is required' : null,
              onSaved: (value) {
                _address = value;
              },
            ),
            Text('ServicerId: ${selectedServicer.servicerId}'),
            FilledButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    String? userId = ref.watch(authNotifierProvider).id;

                    ServiceRequest newServiceRequest = ServiceRequest(
                        user: userId!,
                        servicer: selectedServicer.servicerId,
                        serviceType: _serviceType!,
                        address: _address!,
                        instructions: 'NO MF instructions',
                        preferredTime: DateTime.now());

                    await ref
                        .read(serviceRequestNotifierProvider.notifier)
                        .createRequest(newServiceRequest);

                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Service Requested!')));
                    context.go('/');
                  }
                },
                child: Text('Submit')),
          ],
        ));
  }
}
