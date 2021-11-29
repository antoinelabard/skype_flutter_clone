import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skype_flutter_clone/models/contact.dart';
import 'package:test/test.dart';

void main() {
  test('Load contact data from map', () {
    var now = Timestamp.now();
    Map<String, dynamic> map = {'contact_id': 'testId', 'added_on': now};

    var contact = Contact.fromMap(map);

    expect(contact.uid, 'testId');
    expect(contact.addedOn, now);
  });
}
