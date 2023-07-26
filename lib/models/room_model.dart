class RoomModel {
  final String roomId, creator, password;
  final int broadcastType, studyType, isPublic, chatType;

  RoomModel(
      {required this.roomId,
      required this.creator,
      required this.password,
      required this.broadcastType,
      required this.studyType,
      required this.isPublic,
      required this.chatType});

  RoomModel.fromJson(Map<String, dynamic> json)
      : roomId = json["roomId"],
        creator = json["creator"],
        password = json["password"],
        broadcastType = json["broadcastType"],
        studyType = json["studyType"],
        isPublic = json["isPublic"],
        chatType = json["chatType"];

  Map<String, dynamic> toJson() {
    return {
      'roomId': roomId,
      'creator': creator,
      'password': password,
      'broadcastType': broadcastType,
      'studyType': studyType,
      'isPublic': isPublic,
      'chatType': chatType,
    };
  }
}
