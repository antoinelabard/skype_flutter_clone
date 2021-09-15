import 'dart:io';

import 'package:skype_flutter_clone/provider/image_upload_provider.dart';
import 'package:skype_flutter_clone/resources/firebase_methods.dart';

class FireBaseRepository {
  FirebaseMethods _firebaseMethods = FirebaseMethods();

  uploadImage(
          {required File image,
          required String receiverId,
          required String senderId,
          required ImageUploadProvider imageUploadProvider}) =>
      _firebaseMethods.uploadImage(
          image, receiverId, senderId, imageUploadProvider);
}
