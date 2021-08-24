import 'package:flutter/material.dart';
import 'package:restaurant_apps/helper/navigation_helper.dart';

import 'package:restaurant_apps/theme/color.dart';

class CustomBackButton extends StatelessWidget {
  final double size;
  final double buttonSize;
  const CustomBackButton({
    Key? key,
    required this.size,
    required this.buttonSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigation.back();
      },
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: whiteColor,
        ),
        child: Center(
          child: Icon(
            Icons.arrow_back_ios_new,
            size: buttonSize,
          ),
        ),
      ),
    );
  }
}
