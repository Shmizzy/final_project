import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yardex/models/servicer.dart';

part 'servicer_provider.g.dart';

@riverpod
class ServicerNotifier extends _$ServicerNotifier {
  final String _servicerUrl = 'http://10.0.2.2:3000/markers/';

  @override
  Servicer? build() {
    return null;
  }

  Future<void> loadServicer(String profileId) async {
    try {
      final url = '$_servicerUrl$profileId';
      print('Fetching from URL: $url');
      final res = await http
          .get(Uri.parse(url), headers: {'Content-Type': 'application/json'});
      print('Response status: ${res.statusCode}');
      print('Response body: ${res.body}');
      if (res.statusCode == 200) {
        final Map<String, dynamic> decodedJson = json.decode(res.body);
        state = Servicer.fromJson(decodedJson);
      } else
        print('failed to load servicer data ${res.body}');
    } catch (e) {
      throw Exception('Error fetching servicer... $e');
    }
  }
}
