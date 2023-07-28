class MessageModel {
  final int userId;
  final String sender;
  final String roomId;
  final DateTime timestamp;
  final String content;

  MessageModel(
      {required this.userId,
      required this.sender,
      required this.roomId,
      required this.timestamp,
      required this.content});

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'sender': sender,
        'roomId': roomId,
        'timestamp': timestamp.toIso8601String(),
        'content': content
      };

  MessageModel.fromJson(Map<String, dynamic> json)
      : userId = json["userId"],
        sender = json["sender"],
        roomId = json["roomId"],
        timestamp = DateTime.parse(json["timestamp"]),
        content = json["content"];
}
