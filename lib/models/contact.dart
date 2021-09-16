import 'package:cloud_firestore/cloud_firestore.dart';

class Contact {
  late String uid;
  late Timestamp addedOn;

  Contact({required this.uid, required this.addedOn});

  Map toMap() {
    var data = Map<String, dynamic>();
    data['contact_id'] = uid;
    data['added_on'] = addedOn;
    return data;
  }

  Contact.fromMap(Map<String, dynamic> mapData) {
    this.uid = mapData['contact_id'];
    this.addedOn = mapData['added_on'];
  }
}
