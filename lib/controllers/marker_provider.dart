import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yardex/models/marker.dart';

part 'marker_provider.g.dart';

@riverpod
class MarkerNotifier extends _$MarkerNotifier {
  final String _markerUrl = 'http://10.0.2.2:3000/marker/';

  @override
  List<CustomMarker> build() {
    return const [];
  }

  Future<void> loadMarkers() async {
    state = [];
    try {
      final res = await http.get(
        Uri.parse(_markerUrl),
        headers: {'Content-Type': 'application/json'},
      );
      if (res.statusCode == 200) {
        List<dynamic> markerList = json.decode(res.body);
        state = markerList.map((marker) => CustomMarker.fromJson(marker)).toList();
      } else {
        print('Failed to load markers: ${res.body}');
        state = [];
      }
    } catch (e) {
      throw Exception('Error fetching markers... $e');
    }
  }
  
}
