import 'package:firebase_auth/firebase_auth.dart';
import 'package:skype_flutter_clone/models/local_user.dart';
import 'package:skype_flutter_clone/models/message.dart';
import 'package:skype_flutter_clone/resources/firebase_methods.dart';

class FireBaseRepository {
  FirebaseMethods _firebaseMethods = FirebaseMethods();

  Future<User> getCurrentUser() => _firebaseMethods.getCurrentUser();

  Future<UserCredential> signIn() => _firebaseMethods.signIn();

  Future<bool> authenticateUser(User user) =>
      _firebaseMethods.authenticateUser(user);

  Future<void> addDataToDb(User user) => _firebaseMethods.addDataToDb(user);

  Future<void> signOut() => _firebaseMethods.signOut();

  Future<List<LocalUser>> fetchAllUsers(User currentUser) =>
      _firebaseMethods.fetchAllUser(currentUser);

  Future<void> addMessageToDb(
          Message message, LocalUser sender, LocalUser receiver) async =>
      _firebaseMethods.addMessageToDb(message, sender, receiver);
}
