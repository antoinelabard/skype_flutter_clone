import 'package:flutter/material.dart';
import 'package:skype_flutter_clone/screens/page_views/widgets/user_details_container.dart';
import 'package:skype_flutter_clone/utils/Constants.dart';

class UserCircle extends StatelessWidget {
  final String text;

  const UserCircle({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => showModalBottomSheet(
            context: context,
            backgroundColor: Constants.blackColor,
            builder: (context) => UserDetailsContainer(
                  isScrollControlled: true,
                )),
        child: Container(
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
                  text,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Constants.lightBlueColor,
                      fontSize: 13),
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
        ),
      );
}
