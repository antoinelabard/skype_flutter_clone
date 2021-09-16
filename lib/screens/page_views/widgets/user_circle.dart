import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skype_flutter_clone/provider/user_provider.dart';
import 'package:skype_flutter_clone/utils/Constants.dart';
import 'package:skype_flutter_clone/utils/utils.dart';

class UserCircle extends StatelessWidget {
  const UserCircle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Constants.separatorColor),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              Utils.getInitials(userProvider.getUser().name),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: Constants.lightBlueColor,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              height: 12,
              width: 12,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Constants.blackColor, width: 2),
                  color: Constants.onlineDotColor),
            ),
          )
        ],
      ),
    );
  }
}
