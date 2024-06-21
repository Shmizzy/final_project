class CustomMarker {
  final String id;
  final String servicerId;
  final String status;
  final double latitude;
  final double longitude;

  CustomMarker(
      {required this.id,
      required this.servicerId,
      required this.status,
      required this.latitude,
      required this.longitude});

  factory CustomMarker.fromJson(Map<String, dynamic> json) {
    return CustomMarker(
      id: json['_id'],
      servicerId: json['_id'],
      latitude: json['location']['coordinates'][1],
      longitude: json['location']['coordinates'][0],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'servicer': servicerId,
      'location': {
        'type': 'Point',
        'coordinates': [longitude, latitude]
      },
      'status': status,
    };
  }
}
