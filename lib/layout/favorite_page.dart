import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_apps/layout/support_content_page.dart';
import 'package:restaurant_apps/provider/connectivity_provider.dart';
import 'package:restaurant_apps/provider/database_provider.dart';
import 'package:restaurant_apps/theme/color.dart';
import 'package:restaurant_apps/theme/typography.dart';
import 'package:restaurant_apps/widget/resto_list.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Provider.of<ConnectivityProvider>(context, listen: false)
          .startMonitoring();
    });
  }

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
            child: Consumer<ConnectivityProvider>(
              builder: (context, status, child) {
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
                  return _buildOnInternetActive();
                } else {
                  return SizedBox();
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOnInternetActive() {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24),
            Text(
              'My Favorite Restaurants!',
              style: headerTextStyle,
            ),
            SizedBox(height: 16),
            Consumer<DatabaseProvider>(
              builder: (context, provider, child) {
                if (provider.state == DatabaseResultState.NoData) {
                  return SupportContentPage(
                    imageAssets: 'assets/images/204_no_content.png',
                    message: provider.message,
                    width: 250,
                  );
                } else if (provider.state == DatabaseResultState.Error) {
                  return SupportContentPage(
                    imageAssets: 'assets/images/404_not_found.png',
                    message: provider.message,
                    width: 250,
                  );
                } else if (provider.state == DatabaseResultState.HasData) {
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: provider.favorites.length,
                    itemBuilder: (context, index) {
                      return RestoList(resto: provider.favorites[index]);
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 8);
                    },
                  );
                } else {
                  return SizedBox();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
