import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skype_flutter_clone/screens/page_views/search_screen.dart';
import 'package:skype_flutter_clone/utils/Constants.dart';

class QuietBox extends StatelessWidget {
  const QuietBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Container(
          color: Constants.separatorColor,
          padding: EdgeInsets.symmetric(vertical: 35, horizontal: 25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("This is where all the contacts are listed",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
              SizedBox(height: 25),
              Text(
                  "Search for your friends and family to start calling or chatting with them",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.normal,
                      fontSize: 18)),
              SizedBox(height: 25),
              TextButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchScreen())),
                child: Text("START SEARCHING"),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
