import 'package:flutter/cupertino.dart';
import 'package:skype_flutter_clone/models/local_user.dart';
import 'package:skype_flutter_clone/repositories/firebase/auth_methods.dart';

/// Provides an instance of the active user. This is meant to provide the user
/// data as a singleton, and always fetch the same unique instance of the logged
/// in user. If the user is not initialized when its assessor is called, then
/// UserProvider initialize it automatically.
class UserProvider with ChangeNotifier {
  var _authMethods = AuthMethods();
  LocalUser? _user;

  getUser() => _user;

  Future<void> refreshUser() async {
    LocalUser user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
