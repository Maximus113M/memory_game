class UserDataModel {
  final String id;
  String name;
  String email;

  UserDataModel({required this.id, required this.name, required this.email});

  factory UserDataModel.fromJson(json) => UserDataModel(
        id: json['id'],
        name: json['name'],
        email: json['email'],
      );
}
