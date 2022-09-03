class ChatModel {
  String? sender;
  String? message;
  DateTime? time;
  String? avatarUrl;
  ChatModel({
    this.sender,
    this.message,
    this.time,
    this.avatarUrl,
  });

  ChatModel.fromJson(Map<String, dynamic> json) {
    sender = json['sender'];
    message = json['message'];
    time = json['time'];
    avatarUrl = json['avatarUrl'];
  }
  toJson() => {
        "sender": sender,
        "message": message,
        "time": time,
        "avatarUrl": avatarUrl,
      };
}
