import 'package:firebase_auth/firebase_auth.dart';
import 'package:skype_flutter_clone/resources/firebase_methods.dart';

class FireBaseRepository {
  FirebaseMethods _firebaseMethods = FirebaseMethods();
  Future<User> getCurrentUser() => _firebaseMethods.getCurrentUser();
}