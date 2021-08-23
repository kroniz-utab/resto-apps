import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_apps/layout/support_content_page.dart';
import 'package:restaurant_apps/provider/database_provider.dart';
import 'package:restaurant_apps/theme/color.dart';
import 'package:restaurant_apps/theme/typography.dart';
import 'package:restaurant_apps/widget/resto_list.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

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
                        } else if (provider.state ==
                            DatabaseResultState.Error) {
                          return SupportContentPage(
                            imageAssets: 'assets/images/404_not_found.png',
                            message: provider.message,
                            width: 250,
                          );
                        } else if (provider.state ==
                            DatabaseResultState.HasData) {
                          return ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: provider.favorites.length,
                            itemBuilder: (context, index) {
                              return RestoList(
                                  resto: provider.favorites[index]);
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
            ),
          ),
        ),
      ),
    );
  }
}
