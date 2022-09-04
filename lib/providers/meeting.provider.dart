import 'package:flutter/material.dart';
import 'package:pp_stream_mobile_app/models/meeting.model.dart';

class MeetingsProvider extends ChangeNotifier {
  List<MeetingModel> _meetings = [];
  List<MeetingModel> _publicMeetings = [];
  MeetingModel? _selectedMeeting;

  List<MeetingModel> get meetings => _meetings;

  void addMeeting(MeetingModel meeting) {
    _meetings.add(meeting);
    notifyListeners();
  }

  void updateMeeting(MeetingModel meeting) {
    _meetings.removeWhere((element) => element.id == meeting.id);
    _meetings.add(meeting);
    notifyListeners();
  }

  void setSelectMeeting(MeetingModel meeting) {
    _selectedMeeting = meeting;
    notifyListeners();
  }

  void setPublicMeetings(List<MeetingModel> meetings) {
    _publicMeetings = meetings;
    notifyListeners();
  }

  void setAllMeetings(List<MeetingModel> meetings) {
    _meetings = meetings;
    notifyListeners();
  }

  List<MeetingModel> get publicMeetings => _publicMeetings;

  MeetingModel? get selectedMeeting => _selectedMeeting;
}
