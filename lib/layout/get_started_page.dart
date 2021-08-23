import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_apps/layout/main_page.dart';
import 'package:restaurant_apps/provider/preferences_provider.dart';
import 'package:restaurant_apps/theme/color.dart';
import 'package:restaurant_apps/theme/typography.dart';

class GetStartedPage extends StatefulWidget {
  static const routeName = '/getStarted';

  const GetStartedPage({Key? key}) : super(key: key);

  @override
  _GetStartedPageState createState() => _GetStartedPageState();
}

class _GetStartedPageState extends State<GetStartedPage>
    with SingleTickerProviderStateMixin {
  final _fadeController = FadeInController(autoStart: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/started_bg.png',
              fit: BoxFit.fill,
            ),
          ),
          Container(
            decoration: new BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0x00000000),
                  blackColor,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.6, 1],
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.5,
            bottom: 50,
            left: 24,
            right: 24,
            child: FadeIn(
              duration: Duration(seconds: 1),
              curve: Curves.easeIn,
              controller: _fadeController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Explore the heart and \nsoul of Foods!',
                    style: titleStartedTextStyle,
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Find the best experience of \neating foods with us!',
                      style: subtitleStartedTextStyle,
                    ),
                  ),
                  Consumer<PreferencesProvider>(
                    builder: (context, provider, child) {
                      return ElevatedButton(
                        onPressed: () {
                          provider.setNotFirstLogin();
                          Navigator.pushReplacementNamed(
                            context,
                            MainPage.routeName,
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 30,
                          ),
                          child: Text(
                            'Get Started',
                            style: buttonTextStyle,
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(mainColor),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(color: mainColor),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
