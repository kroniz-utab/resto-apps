import 'package:flutter/material.dart';
import 'package:restaurant_apps/layout/detail_resto.dart';
import 'package:restaurant_apps/model/restaurants.dart';
import 'package:restaurant_apps/theme/color.dart';
import 'package:restaurant_apps/theme/typography.dart';
import 'package:restaurant_apps/widget/resto_card.dart';
import 'package:restaurant_apps/widget/resto_list.dart';
import 'package:restaurant_apps/widget/search_box_widget.dart';

class HomePage extends StatelessWidget {
  static const double _paddingValue = 24.0;
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
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
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: _paddingValue,
                    top: _paddingValue,
                    right: _paddingValue,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(
                          'assets/images/profile.png',
                          width: 60,
                          height: 60,
                        ),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome',
                            style: welcomeTextStyle,
                          ),
                          Text(
                            'Ade Hermawan Fajri',
                            style: welcomeNameTextStyle,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: _paddingValue),
                  child: SearchBox(),
                ),
                SizedBox(height: 16),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: _paddingValue),
                  child: Text(
                    'Recommended',
                    style: headerTextStyle,
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  height: 250,
                  child: _buildBestRestaurant(context),
                ),
                SizedBox(height: 16),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: _paddingValue),
                  child: Text(
                    'Top Restaurant',
                    style: headerTextStyle,
                  ),
                ),
                _buildRestaurantList(context),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding _buildRestaurantList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: _paddingValue,
        vertical: 16.0,
      ),
      child: FutureBuilder<String>(
        future: DefaultAssetBundle.of(context)
            .loadString('assets/json/local_restaurant.json'),
        builder: (context, snapshot) {
          final List<Restaurants> restoData = parseAllRestaurant(snapshot.data);
          return ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: restoData.length,
            itemBuilder: (context, index) {
              final Restaurants resto = restoData[index];
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    DetailResto.routeName,
                    arguments: resto,
                  );
                },
                child: RestoList(
                  restoRating: resto.rating.toString(),
                  restoLocation: resto.city,
                  restoName: resto.name,
                  imgUrl: resto.pictureId,
                ),
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: 10);
            },
          );
        },
      ),
    );
  }

  FutureBuilder<String> _buildBestRestaurant(BuildContext context) {
    return FutureBuilder<String>(
      future: DefaultAssetBundle.of(context)
          .loadString('assets/json/local_restaurant.json'),
      builder: (context, snapshot) {
        final List<Restaurants> restoBest = parseBestRestaurant(snapshot.data);
        return ListView(
          scrollDirection: Axis.horizontal,
          children: [
            SizedBox(width: _paddingValue),
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: restoBest.length,
              itemBuilder: (context, index) {
                final Restaurants restoData = restoBest[index];
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      DetailResto.routeName,
                      arguments: restoData,
                    );
                  },
                  child: RestoCard(
                    location: restoData.city,
                    restoName: restoData.name,
                    rating: restoData.rating,
                    imgUrl: restoData.pictureId,
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(width: 10);
              },
            ),
            SizedBox(width: _paddingValue),
          ],
        );
      },
    );
  }
}
