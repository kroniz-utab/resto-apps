import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_apps/helper/notification_helper.dart';
import 'package:restaurant_apps/layout/detail_resto.dart';
import 'package:restaurant_apps/layout/explore_page.dart';
import 'package:restaurant_apps/layout/favorite_page.dart';
import 'package:restaurant_apps/layout/profile_page.dart';
import 'package:restaurant_apps/layout/home_page.dart';
import 'package:restaurant_apps/theme/color.dart';

class MainPage extends StatefulWidget {
  static const routeName = '/';

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _bottomNavIndex = 0;
  late PageController _pageController;
  final NotificationHelper _notificationHelper = NotificationHelper();

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _notificationHelper
        .configureSelectNotificationSubject(DetailResto.routeName);
  }

  @override
  void dispose() {
    _pageController.dispose();
    selectNotiicationSubject.close();
    super.dispose();
  }

  List<Widget> _bottomNavBarItems = [
    Icon(Icons.home_outlined, size: 30, color: whiteColor),
    Icon(Icons.favorite_outline, size: 30, color: whiteColor),
    Icon(Icons.explore_outlined, size: 30, color: whiteColor),
    Icon(Icons.person_outline, size: 30, color: whiteColor),
  ];

  List<Widget> _pageList = [
    HomePage(),
    FavoritePage(),
    ExplorePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (value) {
            setState(() => _bottomNavIndex = value);
          },
          children: _pageList,
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: _bottomNavIndex,
        items: _bottomNavBarItems,
        backgroundColor: bgGradientColor.withOpacity(.25),
        height: 50,
        color: mainColor,
        onTap: (value) {
          setState(() {
            _bottomNavIndex = value;
            _pageController.animateToPage(
              value,
              duration: Duration(milliseconds: 600),
              curve: Curves.easeOutCubic,
            );
          });
        },
      ),
    );
  }
}
