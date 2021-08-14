import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:skype_flutter_clone/constants/strings.dart';
import 'package:skype_flutter_clone/models/local_user.dart';
import 'package:skype_flutter_clone/models/message.dart';
import 'package:skype_flutter_clone/provider/image_upload_provider.dart';
import 'package:skype_flutter_clone/utils/utils.dart';

class FirebaseMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  static final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  late Reference _firebaseReference;
  var _userCollection = firebaseFirestore.collection(USERS_COLLECTION);

  Future<User> getCurrentUser() async {
    User currentUser = _auth.currentUser!;
    return currentUser;
  }

  Future<UserCredential> signIn() async {
    GoogleSignInAccount? _googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication _googleSignInAuthentication =
        await _googleSignInAccount!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: _googleSignInAuthentication.accessToken,
        idToken: _googleSignInAuthentication.idToken);
    UserCredential userCredential =
        await _auth.signInWithCredential(credential);
    return userCredential;
  }

  Future<bool> authenticateUser(User user) async {
    QuerySnapshot result = await firebaseFirestore
        .collection(USERS_COLLECTION)
        .where(EMAIL_FIELD, isEqualTo: user.email)
        .get();
    final List<DocumentSnapshot> docs = result.docs;
    return docs.length == 0;
  }

  Future<void> addDataToDb(User currentUser) async {
    LocalUser user = LocalUser(
        uid: currentUser.uid,
        email: currentUser.email,
        name: currentUser.displayName,
        profilePhoto: currentUser.photoURL,
        username: Utils.getUsername(currentUser.email!));
    firebaseFirestore
        .collection(USERS_COLLECTION)
        .doc(user.uid)
        .set(user.toMap());
  }

  Future<void> signOut() async {
    _googleSignIn.disconnect();
    _googleSignIn.signOut();
    return await _auth.signOut();
  }

  Future<List<LocalUser>> fetchAllUser(User currentUser) async {
    List<LocalUser> userList = [];
    QuerySnapshot querySnapshot =
        await firebaseFirestore.collection(USERS_COLLECTION).get();
    for (var i = 0; i < querySnapshot.docs.length; i++) {
      if (querySnapshot.docs[i].id != currentUser.uid) {
        userList.add(LocalUser.fromMap(
            querySnapshot.docs[i].data() as Map<String, dynamic>));
      }
    }
    return userList;
  }

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

  Future<LocalUser> getUserDetails() async {
    User currentUser = getCurrentUser() as User;

    var documentSnapshot = await _userCollection.doc(currentUser.uid).get();

    return LocalUser.fromMap(documentSnapshot.data()!);
  }
}
