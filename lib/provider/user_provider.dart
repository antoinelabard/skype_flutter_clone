import 'package:flutter/cupertino.dart';
import 'package:skype_flutter_clone/models/local_user.dart';
import 'package:skype_flutter_clone/resources/firebase_repository.dart';

class UserProvider with ChangeNotifier {
  late LocalUser _user;

  getUser() => _user;
  FireBaseRepository _fireBaseRepository = FireBaseRepository();

  void refreshUser() async {
    LocalUser user = await _fireBaseRepository.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
