import 'package:flutter/material.dart';
import 'package:restaurant_apps/helper/preferences_helper.dart';
import 'package:restaurant_apps/layout/get_started_page.dart';
import 'package:restaurant_apps/layout/main_page.dart';
import 'package:restaurant_apps/theme/color.dart';
import 'package:restaurant_apps/theme/typography.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);
  static const routeName = '/splash';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future firstLoginCheck() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool(PreferencesHelper.FIRST_LOGIN) ?? true) {
      Navigator.of(context).pushReplacementNamed(GetStartedPage.routeName);
    } else {
      Navigator.of(context).pushReplacementNamed(MainPage.routeName);
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      firstLoginCheck();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: Stack(
        children: [
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/app_icon.png',
                  height: 150,
                ),
                Text(
                  'RestoGram',
                  style: titleStartedTextStyle,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Powered By:',
                    style: subtitleStartedTextStyle,
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/idcamp_logo.png',
                        height: 25,
                      ),
                      SizedBox(width: 16),
                      Image.asset(
                        'assets/images/dicoding_logo.png',
                        height: 25,
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
