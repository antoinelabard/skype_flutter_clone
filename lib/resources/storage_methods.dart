import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:skype_flutter_clone/provider/image_upload_provider.dart';

import 'chat_methods.dart';

class StorageMethods {
  static final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  late Reference _storageReference;

  void uploadImage({
    required File image,
    required String receiverId,
    required String senderId,
    required ImageUploadProvider imageUploadProvider,
  }) async {
    final _chatMethods = ChatMethods();
    imageUploadProvider.setToLoading();
    String url = await uploadImageToStorage(image) as String;
    imageUploadProvider.setToIdle();
    _chatMethods.setImageMsg(url, receiverId, senderId);
  }

  Future<String?>? uploadImageToStorage(File imageFile) async {
    try {
      _storageReference = FirebaseStorage.instance
          .ref()
          .child('${DateTime.now().microsecondsSinceEpoch}');
      UploadTask _uploadTask = _storageReference.putFile(imageFile);
      var url =
          await (await _uploadTask.whenComplete(() {})).ref.getDownloadURL();
      return url;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
