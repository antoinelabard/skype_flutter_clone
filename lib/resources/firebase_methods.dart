import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:skype_flutter_clone/models/local_user.dart';
import 'package:skype_flutter_clone/utils/utils.dart';

class FirebaseMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  static final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

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
        .collection("users")
        .where("email", isEqualTo: user.email)
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
    firebaseFirestore.collection("users").doc(user.uid).set(user.toMap());
  }

  Future<void> signOut() async {
    _googleSignIn.disconnect();
    _googleSignIn.signOut();
    return await _auth.signOut();
  }

  Future<List<LocalUser>> fetchAllUser(User currentUser) async {
    List<LocalUser> userList = []; //<LocalUser>.filled(0, LocalUser());
    QuerySnapshot querySnapshot =
        await firebaseFirestore.collection("users").get();
    for (var i = 0; i < querySnapshot.docs.length; i++) {
      if (querySnapshot.docs[i].id != currentUser.uid) {
        userList.add(LocalUser.fromMap(
            querySnapshot.docs[i].data() as Map<String, dynamic>));
      }
    }
    return userList;
  }
}
