import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:skype_flutter_clone/constants/strings.dart';
import 'package:skype_flutter_clone/enum/user_state.dart';
import 'package:skype_flutter_clone/models/local_user.dart';
import 'package:skype_flutter_clone/utils/utils.dart';

/// Provides all the tools to authenticate, log in and log the user out of the
/// Firebase database.
class AuthMethods {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  static final CollectionReference _userCollection =
      _firestore.collection(USERS_COLLECTION);

  /// Fetch the user data from the Firebase database.
  Future<User> getCurrentUser() async {
    return _auth.currentUser!;
  }

  /// Return the user data as a LocalUser for local processing.
  Future<LocalUser> getUserDetails() async {
    User currentUser = await getCurrentUser();

    DocumentSnapshot documentSnapshot =
        await _userCollection.doc(currentUser.uid).get();

    return LocalUser.fromMap(documentSnapshot.data() as Map<String, dynamic>);
  }

  /// Sign the user using his Google account. Return the user's newly created
  /// information.
  Future<User> signIn() async {
    GoogleSignInAccount? _signInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication _signInAuthentication =
        await _signInAccount!.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: _signInAuthentication.accessToken,
        idToken: _signInAuthentication.idToken);

    User user = (await _auth.signInWithCredential(credential)).user!;
    return user;
  }

  /// Tells whether the user already exists or not.
  Future<bool> authenticateUser(User user) async {
    QuerySnapshot result = await firestore
        .collection(USERS_COLLECTION)
        .where(EMAIL_FIELD, isEqualTo: user.email)
        .get();

    final List<DocumentSnapshot> docs = result.docs;

    //if user is registered then length of list > 0 or else less than 0
    return docs.length == 0;
  }

  /// Writes down in the database the information of the given user.
  Future<void> addDataToDb(User currentUser) async {
    String username = Utils.getUsername(currentUser.email ?? "");

    var user = LocalUser(
        uid: currentUser.uid,
        email: currentUser.email,
        name: currentUser.displayName,
        profilePhoto: currentUser.photoURL,
        username: username);

    firestore
        .collection(USERS_COLLECTION)
        .doc(currentUser.uid)
        .set(user.toMap());
  }

  Future<List<LocalUser>> fetchAllUsers(User currentUser) async {
    List<LocalUser> userList = [];

    QuerySnapshot querySnapshot =
        await firestore.collection(USERS_COLLECTION).get();
    for (var i = 0; i < querySnapshot.docs.length; i++) {
      if (querySnapshot.docs[i].id != currentUser.uid) {
        userList.add(LocalUser.fromMap(
            querySnapshot.docs[i].data() as Map<String, dynamic>));
      }
    }
    return userList;
  }

  Future<bool> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  /// Define the state of the user accordingly to the ones allowed by
  /// [UserState].
  void setUserState({required String userId, required UserState userState}) {
    int stateNum = Utils.stateTuNum(userState);
    _userCollection.doc(userId).update({"state": stateNum});
  }

  /// Fetch all the information related to a user in the Firebase database.
  Stream<DocumentSnapshot> getUserStream({required String uid}) =>
      _userCollection.doc(uid).snapshots();

  Future<LocalUser?>? getUserDetailsById(String id) async {
    try {
      var documentSnapshot = await _userCollection.doc(id).get();
      return LocalUser.fromMap(documentSnapshot.data() as Map<String, dynamic>);
    } catch (e) {
      print(e);
      return null;
    }
  }
}
