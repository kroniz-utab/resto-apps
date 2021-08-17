import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_apps/api/api_service.dart';
import 'package:restaurant_apps/layout/support_content_page.dart';
import 'package:restaurant_apps/layout/home_page.dart';
import 'package:restaurant_apps/provider/resto_best_provider.dart';
import 'package:restaurant_apps/provider/resto_provider.dart';
import 'package:restaurant_apps/theme/color.dart';

class MainPage extends StatefulWidget {
  static const routeName = '/';

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _bottomNavIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  List<Widget> _bottomNavBarItems = [
    Icon(Icons.home_outlined, size: 30, color: whiteColor),
    Icon(Icons.favorite_outline, size: 30, color: whiteColor),
    Icon(Icons.explore_outlined, size: 30, color: whiteColor),
    Icon(Icons.person_outline, size: 30, color: whiteColor),
  ];

  List<Widget> _pageList = [
    MultiProvider(
      providers: [
        ChangeNotifierProvider<RestaurantListProvider>(
          create: (context) => RestaurantListProvider(
            apiServices: ApiServices(),
          ),
        ),
        ChangeNotifierProvider<RestaurantBestProvider>(
          create: (context) => RestaurantBestProvider(
            apiServices: ApiServices(),
          ),
        ),
      ],
      child: HomePage(),
    ),
    SupportContentPage(
      imageAssets: 'assets/images/coming_soon.png',
      message: 'This page will be coming soon!',
    ),
    SupportContentPage(
      imageAssets: 'assets/images/coming_soon.png',
      message: 'This page will be coming soon!',
    ),
    SupportContentPage(
      imageAssets: 'assets/images/coming_soon.png',
      message: 'This page will be coming soon!',
    ),
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
