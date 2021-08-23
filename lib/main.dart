import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_apps/api/api_service.dart';
import 'package:restaurant_apps/helper/database_helper.dart';
import 'package:restaurant_apps/layout/detail_resto.dart';
import 'package:restaurant_apps/layout/get_started_page.dart';
import 'package:restaurant_apps/layout/main_page.dart';
import 'package:restaurant_apps/layout/search_page.dart';
import 'package:restaurant_apps/provider/connectivity_provider.dart';
import 'package:restaurant_apps/provider/database_provider.dart';
import 'package:restaurant_apps/provider/resto_best_provider.dart';
import 'package:restaurant_apps/provider/resto_provider.dart';
import 'package:restaurant_apps/provider/resto_shuffle_provider.dart';
import 'package:restaurant_apps/theme/color.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RestaurantListProvider>(
          create: (context) => RestaurantListProvider(
            apiServices: ApiServices(),
          ),
        ),
        ChangeNotifierProvider<RestaurantShuffleProvider>(
          create: (context) => RestaurantShuffleProvider(
            apiServices: ApiServices(),
          ),
        ),
        ChangeNotifierProvider<RestaurantBestProvider>(
          create: (context) => RestaurantBestProvider(
            apiServices: ApiServices(),
          ),
        ),
        ChangeNotifierProvider<ConnectivityProvider>(
          create: (context) => ConnectivityProvider(),
        ),
        ChangeNotifierProvider<DatabaseProvider>(
          create: (context) => DatabaseProvider(
            databaseHelper: DatabaseHelper(),
          ),
        ),
      ],
      child: MaterialApp(
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
                restoID: ModalRoute.of(context)?.settings.arguments as String,
              ),
          SearchPage.routeName: (context) => SearchPage(),
        },
      ),
    );
  }
}
