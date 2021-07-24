import 'package:flutter/material.dart';
import 'package:skype_flutter_clone/utils/Constants.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final List<Widget> actions;
  final Widget leading;
  final bool centerTitle;

  const CustomAppbar({
    Key? key,
    required this.title,
    required this.actions,
    required this.leading,
    required this.centerTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Constants.blackColor,
            border: Border(
                bottom: BorderSide(
                    color: Constants.separatorColor,
                    width: 1.4,
                    style: BorderStyle.solid))),
        child: AppBar(
          backgroundColor: Constants.blackColor,
          elevation: 0,
          title: title,
          actions: actions,
          leading: leading,
          centerTitle: centerTitle,
        ),
      );

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 10);
}
