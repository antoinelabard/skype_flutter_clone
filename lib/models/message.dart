import 'package:cloud_firestore/cloud_firestore.dart';

/// Stores and retrieve all the data related to a message sent between 2 users.
/// It allows to manage message data without dealing with the map given by the
/// database.
class Message {
  late String senderId;
  late String receiverId;
  late String type;
  late String message;
  String photoUrl = "";
  late Timestamp timestamp;

  Message(
      {required this.senderId,
      required this.receiverId,
      required this.type,
      required this.message,
      required this.timestamp});

  Message.imageMessage(
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
    map['timestamp'] = this.timestamp;
    return map;
  }

  Message.fromMap(Map<String, dynamic> map) {
    this.senderId = map['senderId'];
    this.receiverId = map['receiverId'];
    this.type = map['type'];
    this.message = map['message'];
    this.photoUrl = map['photoUrl'];
    this.timestamp = map['timestamp'];
  }

  toImageMap() {
    var map = Map<String, dynamic>();
    map['senderId'] = this.senderId;
    map['receiverId'] = this.receiverId;
    map['type'] = this.type;
    map['message'] = this.message;
    map['photoUrl'] = this.photoUrl;
    map['timestamp'] = this.timestamp;
    return map;
  }
}
