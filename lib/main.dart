import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skype_flutter_clone/provider/image_upload_provider.dart';
import 'package:skype_flutter_clone/provider/user_provider.dart';
import 'package:skype_flutter_clone/repositories/firebase/auth_methods.dart';
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
  final _authMethods = AuthMethods();

  @override
  Widget build(BuildContext context) {
    // _fireBaseRepository
    // .signOut(); // For test only. Remove to keep the user logged in
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ImageUploadProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider())
      ],
      child: MaterialApp(
        initialRoute: "/",
        theme: ThemeData(brightness: Brightness.dark),
        routes: {
          '/search_screen': (context) => SearchScreen(),
        },
        home: FutureBuilder(
          future: _authMethods.getCurrentUser(),
          builder: (context, AsyncSnapshot<User> snapshot) {
            if (snapshot.hasData) {
              return HomeScreen();
            } else {
              return LoginScreen();
            }
          },
        ),
      ),
    );
  }
}
