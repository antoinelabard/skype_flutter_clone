import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skype_flutter_clone/constants/constants.dart';

class ShimmeringLogo extends StatelessWidget {
  const ShimmeringLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      child: Shimmer.fromColors(
          child: Image.asset("assets/app_logo.png"),
          baseColor: Constants.blackColor,
          highlightColor: Colors.white),
    );
  }
}
