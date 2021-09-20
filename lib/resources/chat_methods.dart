import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skype_flutter_clone/constants/strings.dart';
import 'package:skype_flutter_clone/models/contact.dart';
import 'package:skype_flutter_clone/models/local_user.dart';
import 'package:skype_flutter_clone/models/message.dart';

class ChatMethods {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final _messageCollection = _firestore.collection(MESSAGES_COLLECTION);
  final _userCollection = _firestore.collection(USERS_COLLECTION);

  Future<void> addMessageToDb(
      Message message, LocalUser sender, LocalUser receiver) async {
    var map = message.toMap();

    await _messageCollection
        .doc(message.senderId)
        .collection(message.receiverId)
        .add(map);

    await _messageCollection
        .doc(message.receiverId)
        .collection(message.senderId)
        .add(map);
  }

  void setImageMsg(String url, String receiverId, String senderId) async {
    Message message;

    message = Message.imageMessage(
        message: "IMAGE",
        receiverId: receiverId,
        senderId: senderId,
        photoUrl: url,
        timestamp: Timestamp.now(),
        type: 'image');

    // create imagemap
    var map = message.toImageMap();

    // var map = Map<String, dynamic>();
    await _messageCollection
        .doc(message.senderId)
        .collection(message.receiverId)
        .add(map);

    _messageCollection
        .doc(message.receiverId)
        .collection(message.senderId)
        .add(map);
  }

  addToContacts({required String senderId, required String receiverId}) async {
    Timestamp currentTime = Timestamp.now();
    _userCollection
        .doc(senderId)
        .collection(CONTACTS_COLLECTION)
        .doc(receiverId);
  }

  getContactsDocument({required String of, required String forContact}) =>
      _userCollection.doc(of).collection(CONTACTS_COLLECTION).doc(forContact);

  addToSendersContacts(String senderId, String receiverId, currentTime) async {
    DocumentSnapshot senderSnapshot =
        await getContactsDocument(of: senderId, forContact: receiverId).get();
    if (!senderSnapshot.exists) {
      Contact receiverContact = Contact(uid: receiverId, addedOn: currentTime);
      var receiverMap = receiverContact.toMap();
      await getContactsDocument(of: senderId, forContact: receiverId)
          .setData(receiverMap);
    }
  }

  addToReceiversContacts(
      String senderId, String receiverId, currentTime) async {
    DocumentSnapshot receiverSnapshot =
        await getContactsDocument(of: receiverId, forContact: senderId).get();
    if (!receiverSnapshot.exists) {
      Contact senderContact = Contact(uid: senderId, addedOn: currentTime);
      var senderMap = senderContact.toMap();
      await getContactsDocument(of: receiverId, forContact: senderId)
          .setData(senderMap);
    }
  }

  Stream<QuerySnapshot> fetchContacts({required String userId}) =>
      _userCollection.doc(userId).collection(CONTACTS_COLLECTION).snapshots();

  Stream<QuerySnapshot> fetchLastMessageBetween(
          {required String senderId, required String receiverId}) =>
      _messageCollection
          .doc(senderId)
          .collection(receiverId)
          .orderBy("timestamp")
          .snapshots();
}
