import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_apps/layout/detail_resto.dart';
import 'package:restaurant_apps/layout/support_content_page.dart';
import 'package:restaurant_apps/provider/resto_provider.dart';
import 'package:restaurant_apps/provider/resto_shuffle_provider.dart';
import 'package:restaurant_apps/theme/color.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
        child: Consumer<RestaurantShuffleProvider>(
          builder: (context, provider, child) {
            if (provider.state == ResultShuffleState.Loading) {
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
            } else if (provider.state == ResultShuffleState.NoData) {
              return SupportContentPage(
                imageAssets: 'assets/images/204_no_content.png',
                message: provider.message,
              );
            } else if (provider.state == ResultShuffleState.Error) {
              return SupportContentPage(
                imageAssets: 'assets/images/500_server_error.png',
                message: provider.message,
              );
            } else if (provider.state == ResultShuffleState.HasData) {
              return StaggeredGridView.countBuilder(
                physics: BouncingScrollPhysics(),
                crossAxisCount: 3,
                itemCount: provider.restaurantList.length,
                itemBuilder: (context, index) {
                  var resto = provider.restaurantList[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        DetailResto.routeName,
                        arguments: resto.id,
                      );
                    },
                    child: Hero(
                      tag: resto.id,
                      child: FadeInImage.assetNetwork(
                        placeholder: 'assets/images/placeholder.jpg',
                        image:
                            'https://restaurant-api.dicoding.dev/images/medium/${resto.pictureId}',
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
                staggeredTileBuilder: (index) {
                  return StaggeredTile.count(
                    (index % 7 == 0) ? 2 : 1,
                    (index % 7 == 0) ? 2 : 1,
                  );
                },
                mainAxisSpacing: 2,
                crossAxisSpacing: 2,
              );
            } else {
              return SizedBox();
            }
          },
        ),
      ),
    );
  }
}
