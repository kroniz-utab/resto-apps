import 'package:flutter/material.dart';

import 'package:restaurant_apps/theme/typography.dart';

class SupportContentPage extends StatelessWidget {
  final String imageAssets;
  final String message;
  final double? width;
  SupportContentPage({
    Key? key,
    required this.imageAssets,
    required this.message,
    this.width,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          imageAssets,
          width: width ?? null,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            message,
            style: infoTextStyle,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
