import 'dart:ffi';

import 'package:pp_stream_mobile_app/models/user.dart';

class MeetingModel {
  UserModel? creatorId;
  String? title;
  String? description;
  String? id;
  DateTime? createdAt;
  String? link;
  Bool? closed;
  String? token;

  MeetingModel({
    this.creatorId,
    this.title,
    this.description,
    this.id,
    this.createdAt,
    this.link,
    this.closed,
    this.token,
  });

  factory MeetingModel.fromJson(Map<String, dynamic> json) {
    return MeetingModel(
      creatorId: UserModel.fromJson(json['creatorId']),
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      id: json['_id'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      link: json['link'] ?? '',
      closed: json['closed'] ?? false,
      token: json['token'] ?? '',
    );
  }
}
