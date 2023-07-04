class User {
  final int userId;
  final String userEmail;

  User.fromJson(Map<String, dynamic> json)
      : userId = json["userId"],
        userEmail = json["userEmail"];
}
