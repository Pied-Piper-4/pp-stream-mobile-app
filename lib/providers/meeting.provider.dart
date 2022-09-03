import 'package:flutter/material.dart';
import 'package:pp_stream_mobile_app/models/meeting.model.dart';

class MeetingsProvider extends ChangeNotifier {
  List<MeetingModel> _meetings = [];

  List<MeetingModel> get meetings => _meetings;

  void addMeeting(MeetingModel meeting) {
    _meetings.add(meeting);
    notifyListeners();
  }
}
