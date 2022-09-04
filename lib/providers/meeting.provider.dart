import 'package:flutter/material.dart';
import 'package:pp_stream_mobile_app/models/meeting.model.dart';

class MeetingsProvider extends ChangeNotifier {
  List<MeetingModel> _meetings = [];
  MeetingModel? _selectedMeeting;

  List<MeetingModel> get meetings => _meetings;

  void addMeeting(MeetingModel meeting) {
    _meetings.add(meeting);
    notifyListeners();
  }

  void setSelectMeeting(MeetingModel meeting) {
    _selectedMeeting = meeting;
    notifyListeners();
  }

  void setAllMeetings(List<MeetingModel> meetings) {
    _meetings = meetings;
    notifyListeners();
  }

  MeetingModel? get selectedMeeting => _selectedMeeting;
}
