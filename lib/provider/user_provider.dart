import 'package:flutter/cupertino.dart';
import 'package:skype_flutter_clone/models/local_user.dart';
import 'package:skype_flutter_clone/resources/auth_methods.dart';

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
