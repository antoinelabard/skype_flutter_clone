import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:skype_flutter_clone/constants/strings.dart';
import 'package:skype_flutter_clone/models/local_user.dart';
import 'package:skype_flutter_clone/models/message.dart';
import 'package:skype_flutter_clone/provider/image_upload_provider.dart';

import 'chat_methods.dart';

class FirebaseMethods {
  static final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  late Reference _firebaseReference;

  uploadImage(File image, String receiverId, String senderId,
      ImageUploadProvider imageUploadProvider) async {
    final _chatMethods = ChatMethods();
    imageUploadProvider.setToLoading();
    String url = await uploadImageToStorage(image) as String;
    imageUploadProvider.setToIdle();
    _chatMethods.setImageMsg(url, receiverId, senderId);
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

}
