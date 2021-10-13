import 'package:cloud_firestore/cloud_firestore.dart';

/// Stores all the information related to a contact of the user. It allows to
/// manage contact data without dealing with the map given by the database.
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
