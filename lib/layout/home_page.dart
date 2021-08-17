import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_apps/layout/detail_resto.dart';
import 'package:restaurant_apps/layout/search_page.dart';
import 'package:restaurant_apps/layout/support_content_page.dart';
import 'package:restaurant_apps/provider/connectivity_provider.dart';
import 'package:restaurant_apps/provider/resto_best_provider.dart';
import 'package:restaurant_apps/provider/resto_provider.dart';
import 'package:restaurant_apps/theme/color.dart';
import 'package:restaurant_apps/theme/typography.dart';
import 'package:restaurant_apps/widget/resto_card.dart';
import 'package:restaurant_apps/widget/resto_list.dart';

class HomePage extends StatefulWidget {
  static const double _paddingValue = 24.0;
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();
  }

  @override
  void dispose() {
    Provider.of<ConnectivityProvider>(context, listen: false)
        .startMonitoring()
        .close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Consumer<ConnectivityProvider>(builder: (context, status, _) {
        if (status.status == ConnectionStatus.Offline) {
          return SupportContentPage(
            imageAssets: 'assets/images/404_not_found.png',
            message: status.message == ''
                ? 'Your device is not connected to internet, Make sure your device connected to wifi/celular data first!'
                : status.message,
          );
        } else if (status.status == ConnectionStatus.Error) {
          return SupportContentPage(
            imageAssets: 'assets/images/500_server_error.png',
            message: status.message,
          );
        } else if (status.status == ConnectionStatus.Online) {
          return _buildOverallPage(context);
        } else {
          return SizedBox();
        }
      }),
    );
  }

  Widget _buildOverallPage(BuildContext context) {
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
      child: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: HomePage._paddingValue,
                  top: HomePage._paddingValue,
                  right: HomePage._paddingValue,
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
                padding: const EdgeInsets.symmetric(
                    horizontal: HomePage._paddingValue),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, SearchPage.routeName);
                  },
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13.0),
                        side: BorderSide(
                          color: blackColor.withOpacity(.1),
                          width: 1,
                        ),
                      ),
                      elevation: 3,
                      shadowColor: mainColor.withOpacity(.4),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.search,
                              size: 24,
                              color: darkBlueColor.withOpacity(.2),
                            ),
                            SizedBox(width: 4),
                            Expanded(
                              flex: 2,
                              child: Text(
                                'Search restaurant',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: darkBlueColor.withOpacity(.2),
                                ),
                              ),
                            ),
                            Icon(
                              Icons.cancel,
                              size: 24,
                              color: darkBlueColor.withOpacity(.2),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: HomePage._paddingValue),
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
                padding: const EdgeInsets.symmetric(
                    horizontal: HomePage._paddingValue),
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
    );
  }

  Widget _buildRestaurantList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: HomePage._paddingValue,
        vertical: 16.0,
      ),
      child: Consumer<RestaurantListProvider>(
        builder: (context, state, _) {
          if (state.state == ResultListState.Loading) {
            return Center(
              child: Container(
                height: 75,
                child: LoadingIndicator(
                  indicatorType: Indicator.lineScale,
                  colors: [
                    mainColor,
                    mainColor.withOpacity(.8),
                    mainColor.withOpacity(.6),
                    mainColor.withOpacity(.4),
                    mainColor.withOpacity(.2),
                  ],
                  strokeWidth: 1,
                ),
              ),
            );
          } else if (state.state == ResultListState.NoData) {
            return Center(
              child: Text(state.message),
            );
          } else if (state.state == ResultListState.Error) {
            return Center(
              child: Text(state.message),
            );
          } else if (state.state == ResultListState.HasData) {
            return ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: state.restaurantList.restaurants.length,
              itemBuilder: (context, index) {
                var resto = state.restaurantList.restaurants[index];
                return RestoList(
                  restoRating: resto.rating.toString(),
                  restoLocation: resto.city,
                  restoName: resto.name,
                  imgID: resto.pictureId,
                  onClick: () {
                    Navigator.pushNamed(
                      context,
                      DetailResto.routeName,
                      arguments: resto.id,
                    );
                  },
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 10);
              },
            );
          } else {
            return Center(
              child: Text(''),
            );
          }
        },
      ),
    );
  }

  Widget _buildBestRestaurant(BuildContext context) {
    return Consumer<RestaurantBestProvider>(
      builder: (context, state, _) {
        if (state.state == ResultBestState.Loading) {
          return Center(
            child: Container(
              height: 75,
              child: LoadingIndicator(
                indicatorType: Indicator.lineScale,
                colors: [
                  mainColor,
                  mainColor.withOpacity(.8),
                  mainColor.withOpacity(.6),
                  mainColor.withOpacity(.4),
                  mainColor.withOpacity(.2),
                ],
                strokeWidth: 1,
              ),
            ),
          );
        } else if (state.state == ResultBestState.NoData) {
          return Center(
            child: Text(state.message),
          );
        } else if (state.state == ResultBestState.Error) {
          return Center(
            child: Text(state.message),
          );
        } else if (state.state == ResultBestState.HasData) {
          return ListView(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            children: [
              SizedBox(width: HomePage._paddingValue),
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: state.restoBest.length,
                itemBuilder: (context, index) {
                  var restoBestData = state.restoBest[index];
                  return RestoCard(
                    location: restoBestData.city,
                    restoName: restoBestData.name,
                    rating: restoBestData.rating,
                    imgID: restoBestData.pictureId,
                    onClick: () {
                      Navigator.pushNamed(
                        context,
                        DetailResto.routeName,
                        arguments: restoBestData.id,
                      );
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(width: 10);
                },
              ),
              SizedBox(width: HomePage._paddingValue),
            ],
          );
        } else {
          return Center(
            child: Text(''),
          );
        }
      },
    );
  }
}
