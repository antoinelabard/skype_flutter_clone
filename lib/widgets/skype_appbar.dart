import 'package:flutter/material.dart';
import 'package:skype_flutter_clone/widgets/custom_appbar.dart';

class SkypeAppbar extends StatelessWidget implements PreferredSizeWidget {
  const SkypeAppbar({Key? key, required this.title, required this.actions})
      : super(key: key);

  final dynamic title;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return CustomAppbar(
        title: title is String
            ? Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              )
            : title,
        actions: actions,
        leading: IconButton(
          icon: Icon(
            Icons.notifications,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        centerTitle: true);
  }

  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10);
}
