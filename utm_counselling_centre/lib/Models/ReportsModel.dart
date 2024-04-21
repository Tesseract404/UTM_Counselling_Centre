import 'package:cloud_firestore/cloud_firestore.dart';

class ReportModel {
  late final String? id;
  late final String? reportid;
  late final String? username;
  late final String? UTMid;
  late final String? content;
  late final String? doctor;
  late final Timestamp? timedate;
  late final bool? approved ;
  late final bool? notified ;
  ReportModel({
    this.id,
    this.username,
    this.UTMid,
    required this.content,
    required this.doctor,
    this.timedate,
    this.reportid,
    this.approved,
    this.notified,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      id: json['id'] as String,
      reportid: json['reportid'] as String,
      username: json['username'] as String,
      UTMid: json['UTMid'] as String,
      content: json['content'] as String,
      doctor: json['doctor'] as String,
      timedate: json['timedate']as Timestamp?,
      approved: json['approved']as bool?,
      notified: json['notified']as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "reportid": reportid,
      "username": username,
      "UTMid": UTMid,
      "content": content,
      "doctor": doctor,
      "timedate": timedate,
      "approved": approved,
      "notified": notified,
    };
  }
}
