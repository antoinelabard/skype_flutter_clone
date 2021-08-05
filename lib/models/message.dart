import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String senderId;
  String receiverId;
  String type;
  String message;
  String photoUrl;
  FieldValue timestamp;

  Message(
      {required this.senderId,
      required this.receiverId,
      required this.type,
      required this.message,
      required this.photoUrl,
      required this.timestamp});

  toMap() {
    var map = Map<String, dynamic>();
    map['senderId'] = this.senderId;
    map['receiverId'] = this.receiverId;
    map['type'] = this.type;
    map['message'] = this.message;
    map['photoUrl'] = this.photoUrl;
    map['timestamp'] = this.timestamp;
    return map;
  }

  fromMap(Map<String, dynamic> map) => Message(
      senderId: map['senderId'],
      receiverId: map['receiverId'],
      type: map['type'],
      message: map['message'],
      photoUrl: map['photoUrl'],
      timestamp: map['timestamp']);
}
