import 'package:flutter/material.dart';
import 'package:restaurant_apps/layout/detail_resto.dart';
import 'package:restaurant_apps/layout/get_started_page.dart';
import 'package:restaurant_apps/layout/main_page.dart';
import 'package:restaurant_apps/model/restaurants.dart';
import 'package:restaurant_apps/theme/color.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant Apps',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        primaryColor: mainColor,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: GetStartedPage.routeName,
      routes: {
        GetStartedPage.routeName: (context) => GetStartedPage(),
        MainPage.routeName: (context) => MainPage(),
        DetailResto.routeName: (context) => DetailResto(
              restaurants:
                  ModalRoute.of(context)?.settings.arguments as Restaurants,
            )
      },
    );
  }
}
