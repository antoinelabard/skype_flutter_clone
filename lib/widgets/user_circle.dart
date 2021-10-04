import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skype_flutter_clone/provider/user_provider.dart';
import 'package:skype_flutter_clone/screens/chat_screens/widgets/cached_image.dart';
import 'package:skype_flutter_clone/screens/page_views/widgets/user_details_container.dart';
import 'package:skype_flutter_clone/utils/Constants.dart';

class UserCircle extends StatelessWidget {
  const UserCircle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    userProvider.refreshUser();
    return GestureDetector(
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
              child: CachedImage(
                userProvider.getUser().profilePhoto,
                isRound: true,
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
}
