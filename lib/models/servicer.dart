class Servicer {
  final String servicerName;
  final String status;
  final String bio;
  final String servicerId;
  final List servicesOffered;
  final double averageRating;
  final double numberOfRatings;

  Servicer(
      {required this.status,
      required this.bio,
      required this.servicerId,
      required this.servicesOffered,
      required this.averageRating,
      required this.numberOfRatings,
      required this.servicerName});

  factory Servicer.fromJson(Map<String, dynamic> json) {
    return Servicer(
      servicerName: json['servicerName'],
      status: json['status'],
      bio: json['bio'],
      servicerId: json['_id'],
      servicesOffered: json['servicesOffered'],
      averageRating: (json['ratings']['average'] as num).toDouble(),
      numberOfRatings: (json['ratings']['numberOfRatings'] as num).toDouble(),
    );
  }
}
