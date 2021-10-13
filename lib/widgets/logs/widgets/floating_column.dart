import 'package:flutter/material.dart';
import 'package:skype_flutter_clone/constants/constants.dart';

class FloatingColumn extends StatelessWidget {
  const FloatingColumn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle, gradient: Constants.fabGradient),
          child: Icon(
            Icons.dialpad,
            color: Colors.white,
            size: 25,
          ),
          padding: EdgeInsets.all(15),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Constants.blackColor,
              border: Border.all(width: 2, color: Constants.gradientColorEnd)),
          child: Icon(
            Icons.add_call,
            color: Constants.gradientColorEnd,
            size: 25,
          ),
          padding: EdgeInsets.all(15),
        )
      ],
    );
  }
}
