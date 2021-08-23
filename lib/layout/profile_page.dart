import 'package:flutter/material.dart';
import 'package:restaurant_apps/theme/color.dart';
import 'package:restaurant_apps/theme/typography.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SizedBox.expand(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                whiteColor,
                bgGradientColor.withOpacity(.25),
              ],
              stops: [0, 1],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 35),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: darkBlueColor.withOpacity(.4),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: Offset(1, 2),
                        ),
                      ],
                    ),
                    child: Image.asset(
                      'assets/images/profile.png',
                      height: 150,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Ade Hermawan Fajri',
                    style: headerTextStyle,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.place,
                        color: darkBlueColor.withOpacity(.5),
                        size: 14,
                      ),
                      Text(
                        'Malang, Jawa Timur',
                        style: welcomeTextStyle,
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Divider(
                    color: darkBlueColor.withOpacity(.1),
                    thickness: 1,
                    indent: 24,
                    endIndent: 24,
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            'Notif me recommendation restaurant every day!',
                            style: infoTextStyle,
                          ),
                        ),
                        Switch.adaptive(
                          value: false,
                          onChanged: (value) {},
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
