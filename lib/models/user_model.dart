class UserModel {
  final int userId;
  final String userName;
  final String userEmail;

  UserModel(
      {required this.userId, required this.userName, required this.userEmail});

  UserModel.fromJson(Map<String, dynamic> json)
      : userId = json["userId"],
        userName = json["userName"],
        userEmail = json["userEmail"];

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userName': userName,
      'userEmail': userEmail,
    };
  }
}
