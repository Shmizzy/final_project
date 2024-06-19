class Servicer {
  final String bio;
  final List servicesOffered;
  final double averageRating;
  final double numberOfRatings;

  Servicer(
      {required this.bio,
      required this.servicesOffered,
      required this.averageRating,
      required this.numberOfRatings});

  factory Servicer.fromJson(Map<String, dynamic> json) {
    return Servicer(
      bio: json['bio'],
      servicesOffered: json['servicesOffered'],
      averageRating: (json['ratings']['average'] as num).toDouble(),
      numberOfRatings: (json['ratings']['numberOfRatings'] as num).toDouble(),
    );
  }
}
