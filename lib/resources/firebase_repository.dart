import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:skype_flutter_clone/models/local_user.dart';
import 'package:skype_flutter_clone/models/message.dart';
import 'package:skype_flutter_clone/provider/image_upload_provider.dart';
import 'package:skype_flutter_clone/resources/firebase_methods.dart';

class FireBaseRepository {
  FirebaseMethods _firebaseMethods = FirebaseMethods();

  Future<void> addMessageToDb(
          Message message, LocalUser sender, LocalUser receiver) async =>
      _firebaseMethods.addMessageToDb(message, sender, receiver);

  uploadImage(
          {required File image,
          required String receiverId,
          required String senderId,
          required ImageUploadProvider imageUploadProvider}) =>
      _firebaseMethods.uploadImage(
          image, receiverId, senderId, imageUploadProvider);
}
