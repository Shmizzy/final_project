import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yardex/models/service_request.dart';

part 'service_request_provider.g.dart';

@riverpod
class ServiceRequestNotifier extends _$ServiceRequestNotifier {
  final String _requestUrl = 'http://10.0.2.2:3000/service-request/create';
  final _storage = FlutterSecureStorage();

  @override
  Map build() {
    return const {};
  }

  Future<void> createRequest(ServiceRequest serviceRequest) async {
    String? token = await _storage.read(key: 'jwt_token');
    if (token == null) {
      print('JWT token not found');
      return;
    }
    try {
      final res = await http.post(
        Uri.parse(_requestUrl),
        headers: {'Content-Type': 'application/json', 'x-auth-token': token},
        body: json.encode(serviceRequest.toJson()),
      );
      if (res.statusCode == 201) {
        //todo
        print('Service request created');
      } else
        print('Failed to create service request: ${res.body}');
    } catch (e) {
      throw Exception('Error creating service request... $e');
    }
  }
}
