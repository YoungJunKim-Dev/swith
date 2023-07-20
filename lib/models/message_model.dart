class MessageModel {
  final String sender;
  final String roomId;
  final DateTime timestamp;
  final String content;

  MessageModel(
      {required this.sender,
      required this.roomId,
      required this.timestamp,
      required this.content});

  Map<String, dynamic> toJson() => {
        'sender': sender,
        'roomId': roomId,
        'timestamp': timestamp.toIso8601String(),
        'content': content
      };

  MessageModel.fromJson(Map<String, dynamic> json)
      : sender = json["sender"],
        roomId = json["roomId"],
        timestamp = json["timestamp"],
        content = json["content"];
}
