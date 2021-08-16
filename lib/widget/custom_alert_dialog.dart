import 'package:flutter/material.dart';

import 'package:restaurant_apps/theme/color.dart';
import 'package:restaurant_apps/theme/typography.dart';

class CustomAlertDialog extends StatelessWidget {
  final String titleMessage;
  final String message;
  final IconData iconData;
  final Function() buttonOnTap;

  const CustomAlertDialog({
    Key? key,
    required this.titleMessage,
    required this.message,
    required this.iconData,
    required this.buttonOnTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: 200,
            child: Padding(
              padding: EdgeInsets.fromLTRB(10, 60, 10, 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        titleMessage,
                        style: alertTittleMessage,
                      ),
                      SizedBox(height: 5),
                      Text(
                        message,
                        style: alertContentMessage,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: buttonOnTap,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        'Okay',
                        style: buttonTextStyle,
                      ),
                    ),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(mainColor),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: -50,
            child: Center(
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: mainColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  iconData,
                  color: whiteColor,
                  size: 50,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
