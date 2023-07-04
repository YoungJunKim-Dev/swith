class RoomModel {
  final String roomId;
  final int broadcastType, studyType;
  final int isPublic;

  RoomModel.fromJson(Map<String, dynamic> json)
      : roomId = json["roomId"],
        broadcastType = json["broadcastType"],
        studyType = json["studyType"],
        isPublic = json["isPublic"];
}
