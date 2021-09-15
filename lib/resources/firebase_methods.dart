import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:skype_flutter_clone/constants/strings.dart';
import 'package:skype_flutter_clone/models/local_user.dart';
import 'package:skype_flutter_clone/models/message.dart';
import 'package:skype_flutter_clone/provider/image_upload_provider.dart';

class FirebaseMethods {
  static final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  late Reference _firebaseReference;

  Future<void> addMessageToDb(
      Message message, LocalUser sender, LocalUser receiver) async {
    var map = message.toMap();
    await firebaseFirestore
        .collection(MESSAGES_COLLECTION)
        .doc(message.senderId)
        .collection(message.receiverId)
        .add(map);
    await firebaseFirestore
        .collection(MESSAGES_COLLECTION)
        .doc(message.receiverId)
        .collection(message.senderId)
        .add(map);
  }

  uploadImage(File image, String receiverId, String senderId,
      ImageUploadProvider imageUploadProvider) async {
    imageUploadProvider.setToLoading();
    String url = await uploadImageToStorage(image) as String;
    imageUploadProvider.setToIdle();
    setImageMessage(url, receiverId, senderId);
  }

  Future<String?>? uploadImageToStorage(File imageFile) async {
    try {
      _firebaseReference = FirebaseStorage.instance
          .ref()
          .child('${DateTime.now().microsecondsSinceEpoch}');
      UploadTask _uploadTask = _firebaseReference.putFile(imageFile);
      var url =
          await (await _uploadTask.whenComplete(() {})).ref.getDownloadURL();
      return url;
    } catch (e) {
      print(e);
      return null;
    }
  }

  setImageMessage(String url, String receiverId, String senderId) async {
    var _message = Message.imageMessage(
        senderId: senderId,
        receiverId: receiverId,
        type: 'image',
        message: "message",
        photoUrl: url,
        timestamp: Timestamp.now());
    var _map = _message.toImageMap();
    await firebaseFirestore
        .collection(MESSAGES_COLLECTION)
        .doc(_message.senderId)
        .collection(_message.receiverId)
        .add(_map);
    await firebaseFirestore
        .collection(MESSAGES_COLLECTION)
        .doc(_message.receiverId)
        .collection(_message.senderId)
        .add(_map);
  }
}
