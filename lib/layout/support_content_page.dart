import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:restaurant_apps/theme/color.dart';

class SupportContentPage extends StatelessWidget {
  final String imageAssets;
  final String message;
  const SupportContentPage({
    Key? key,
    required this.imageAssets,
    required this.message,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white,
            bgGradientColor.withOpacity(.25),
          ],
          stops: [0, 1],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            imageAssets,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              message,
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
