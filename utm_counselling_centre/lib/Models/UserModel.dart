import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  late final String? id;
  late final String? username;
  late final String? email;
  late final String? phone;
  late final String? password;
  late final String? UTMid;

  UserModel(
      {this.id,
      required this.username,
      required this.email,
      required this.phone,
      required this.password,
      required this.UTMid});

  static UserModel fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return UserModel(
        id: snapshot['id'],
        username: snapshot['username'],
        email: snapshot['email'],
        phone: snapshot['phone'],
        password: snapshot['password'],
        UTMid: snapshot['UTMid']);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "username": username,
      "email": email,
      "phone": phone,
      "password": password,
      "UTMid": UTMid,
    };
  }
}
