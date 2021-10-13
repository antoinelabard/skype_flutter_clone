import 'package:flutter/material.dart';
import 'package:skype_flutter_clone/constants/constants.dart';
import 'package:skype_flutter_clone/widgets/custom_tile.dart';

class ModalTile extends StatelessWidget {
  final String title;
  final String subTitle;
  final IconData iconData;
  final Function onTap;

  const ModalTile(
      {Key? key,
      required this.title,
      required this.subTitle,
      required this.iconData,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: CustomTile(
          mini: false,
          leading: Container(
            margin: EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Constants.receiverColor),
            padding: EdgeInsets.all(10),
            child: Icon(
              iconData,
              color: Constants.greyColor,
              size: 38,
            ),
          ),
          subtitle: Text(
            subTitle,
            style: TextStyle(color: Constants.greyColor, fontSize: 14),
          ),
          title: Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
          ),
        ),
      );
}
