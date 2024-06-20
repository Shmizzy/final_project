class ServiceRequest {
  String user;
  String servicer;
  String serviceType;
  String address;
  String instructions;
  DateTime preferredTime;

  ServiceRequest(
      {required this.user,
      required this.servicer,
      required this.serviceType,
      required this.address,
      required this.instructions,
      required this.preferredTime});

  factory ServiceRequest.fromJson(Map<String, dynamic> json) {
    return ServiceRequest(
      user: json['user'],
      servicer: json['servicer'],
      serviceType: json['serviceType'],
      address: json['address'],
      instructions: json['instructions'],
      preferredTime: DateTime.parse(json['preferredTime']),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'user': user,
      'servicer': servicer,
      'serviceType': serviceType,
      'address': address,
      'instructions': instructions,
      'preferredTime': preferredTime.toIso8601String(),
    };
  }
}
