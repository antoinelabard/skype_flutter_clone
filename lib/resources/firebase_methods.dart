import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  static final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<User> getCurrentUser() async {
    User currentUser = await _auth.currentUser!;
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
}
