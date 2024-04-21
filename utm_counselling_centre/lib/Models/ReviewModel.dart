import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewModel {
  final String? reviewId;
  final String? userId;
  final String? userName;
  final String? UTMid;
  final String? counsellor;
  final Timestamp? timeDate;
  final bool? notify;
  final String? awareness1;
  final String? awareness2;
  final String? knowledge1;
  final String? knowledge2;
  final String? skill1;
  final String? skill2;

  ReviewModel({
    this.reviewId,
    this.userId,
    this.userName,
    this.UTMid,
    this.counsellor,
    this.timeDate,
    this.notify,
    this.awareness1,
    this.awareness2,
    this.knowledge1,
    this.knowledge2,
    this.skill1,
    this.skill2,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      reviewId: json['reviewId'] as String?,
      userId: json['userId'] as String?,
      userName: json['userName'] as String?,
      UTMid: json['UTMid'] as String?,
      counsellor: json['counsellor'] as String?,
      timeDate: json['timeDate'] as Timestamp?,
      notify: json['notify'] as bool?,
      awareness1: json['awareness1'] as String?,
      awareness2: json['awareness2'] as String?,
      knowledge1: json['knowledge1'] as String?,
      knowledge2: json['knowledge2'] as String?,
      skill1: json['skill1'] as String?,
      skill2: json['skill2'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reviewId': reviewId,
      'userId': userId,
      'userName': userName,
      'UTMid': UTMid,
      'counsellor': counsellor,
      'timeDate': timeDate,
      'notify': notify,
      'awareness1': awareness1,
      'awareness2': awareness2,
      'knowledge1': knowledge1,
      'knowledge2': knowledge2,
      'skill1': skill1,
      'skill2': skill2,
    };
  }
}
