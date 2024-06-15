class User {
  String email;
  String username;
  String password;

  User({required this.username,required this.email, required this.password});

  Map<String, dynamic> toJson() => {
        'username': username,
        'email': email,
        'password': password,
      };
}
