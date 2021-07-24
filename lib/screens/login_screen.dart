import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skype_flutter_clone/resources/firebase_repository.dart';
import 'package:skype_flutter_clone/screens/home_screen.dart';
import 'package:skype_flutter_clone/utils/Constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FireBaseRepository _repository = FireBaseRepository();
  bool isLoginButtonPressed = false;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      isLoginButtonPressed ? CircularProgressIndicator() : Container(),
      Scaffold(
        backgroundColor: Constants.blackColor,
        body: Center(child: loginButton()),
      ),
    ]);
  }

  loginButton() => Shimmer.fromColors(
        baseColor: Colors.white,
        highlightColor: Constants.senderColor,
        child: Padding(
          padding: EdgeInsets.all(35),
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: TextButton(
              child: Text(
                'LOGIN',
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.2),
              ),
              onPressed: () => performLogin(),
            ),
          ),
        ),
      );

  void performLogin() {
    setState(() {
      isLoginButtonPressed = true;
    });
    _repository.signIn().then((userCredential) {
      authenticateUser(userCredential.user!);
    });
  }

  void authenticateUser(User user) {
    _repository.authenticateUser(user).then((isNewUser) {
      if (isNewUser) {
        _repository.addDataToDb(user).then((value) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return HomeScreen();
          }));
        });
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return HomeScreen();
        }));
      }
    });
  }
}
