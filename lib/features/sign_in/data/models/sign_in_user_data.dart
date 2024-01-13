class SignInUserData {
  final String? name;
  final String email;
  final String password;
  String? id;

  SignInUserData({
    required this.email,
    required this.password,
    this.name,
    this.id,
  });

  Map<String, dynamic> toFirestore() {
    return {
      "id": id,
      "name": name,
      "email": email,
    };
  }
}
