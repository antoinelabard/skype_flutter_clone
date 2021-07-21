import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:skype_flutter_clone/resources/firebase_repository.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FireBaseRepository _repository = FireBaseRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loginButton(),
    );
  }

  loginButton() => Padding(
        padding: EdgeInsets.all(35),
        child: TextButton(
          child: Text(
            'LOGIN',
            style: TextStyle(
                fontSize: 35, fontWeight: FontWeight.w900, letterSpacing: 1.2),
          ),
          onPressed: () => performLogin,
        ),
      );
  void performLogin() {
_repository.signIn().then((userCredential) {
  if (userCredential != null) {
    authenticateUser(userCredential);
  } else {
    print("There was an error.");
  }
});
  }

  void authenticateUser(UserCredential userCredential) {}
}
