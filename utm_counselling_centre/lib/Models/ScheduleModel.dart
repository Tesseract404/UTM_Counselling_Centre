import 'package:cloud_firestore/cloud_firestore.dart';
class ScheduleModel {
  late final String? scheduleid;
  late final String? userid;
  late final String? UTMid;
  late final String? username;
  late final String? counsellor;
  late final Timestamp? timedate;
  late final bool? done ;
  late final bool? approved ;
  late final bool? notified ;

  ScheduleModel({
    this.scheduleid,
    this.username,
    this.userid,
    this.UTMid,
    this.counsellor,
    this.timedate,
    this.done,
    this.approved,
    this.notified
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    return ScheduleModel(
      scheduleid: json['scheduleid'] as String,
      username: json['username'] as String,
      userid: json['userid'] as String,
      UTMid: json['UTMid'] as String,
      counsellor: json['counsellor'] as String,
      timedate: json['timedate']as Timestamp,
      done: json['done']as bool,
      approved: json['approved']as bool,
      notified: json['notified']as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "scheduleid": scheduleid,
      "username": username,
      "userid": userid,
      "UTMid": UTMid,
      "counsellor": counsellor,
      "timedate": timedate,
      "done": done,
      "approved": approved,
      "notified": notified,
    };
  }
}
