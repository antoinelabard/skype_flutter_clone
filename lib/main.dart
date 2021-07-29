import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:skype_flutter_clone/resources/firebase_repository.dart';
import 'package:skype_flutter_clone/screens/home_screen.dart';
import 'package:skype_flutter_clone/screens/login_screen.dart';
import 'package:skype_flutter_clone/screens/page_views/search_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FireBaseRepository _fireBaseRepository = FireBaseRepository();

  @override
  Widget build(BuildContext context) {
    // _fireBaseRepository
    // .signOut(); // For test only. Remove to keep the user logged in
    return MaterialApp(
      initialRoute: "/",
      routes: {
        '/search_screen': (context) => SearchScreen(),
      },
      home: FutureBuilder(
        future: _fireBaseRepository.getCurrentUser(),
        builder: (context, AsyncSnapshot<User> snapshot) {
          if (snapshot.hasData) {
            return HomeScreen();
          } else {
            return LoginScreen();
          }
        },
      ),
    );
  }
}
