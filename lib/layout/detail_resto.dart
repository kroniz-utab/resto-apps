import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

import 'package:restaurant_apps/model/restaurants.dart';
import 'package:restaurant_apps/theme/color.dart';
import 'package:restaurant_apps/theme/typography.dart';
import 'package:restaurant_apps/widget/custom_back_button.dart';
import 'package:restaurant_apps/widget/favorite_button.dart';
import 'package:restaurant_apps/widget/menu_card.dart';

class DetailResto extends StatelessWidget {
  static const routeName = '/detailResto';
  static const _paddingValue = 24.0;

  final Restaurants restaurants;
  const DetailResto({
    Key? key,
    required this.restaurants,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              whiteColor,
              bgGradientColor.withOpacity(.5),
            ],
            stops: [0, 1],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                        child: FadeInImage.assetNetwork(
                          placeholder: 'assets/images/placeholder.jpg',
                          image: restaurants.pictureId,
                          height: 325,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 32),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomBackButton(size: 40, buttonSize: 22),
                            FavoriteButton(size: 40, isFavorite: false),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: _paddingValue),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          restaurants.name,
                          style: detailTitleTextStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.place,
                              color: blackColor.withOpacity(.5),
                              size: 20,
                            ),
                            Text(
                              restaurants.city,
                              style: detailLocationTextStyle,
                            )
                          ],
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Description',
                          style: detailSubitleTextStyle,
                        ),
                        SizedBox(height: 8),
                        ReadMoreText(
                          restaurants.description,
                          trimLines: 2,
                          colorClickableText: mainColor,
                          trimMode: TrimMode.Length,
                          trimCollapsedText: 'Read More',
                          trimExpandedText: ' Show Less',
                          style: detailContentTextStyle,
                        ),
                        SizedBox(height: 8),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: _paddingValue),
                    child: Text(
                      'Foods',
                      style: detailSubitleTextStyle,
                    ),
                  ),
                  SizedBox(height: 8),
                  _buildMenuCardView(restaurants.menus.foods),
                  SizedBox(height: 8),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: _paddingValue),
                    child: Text(
                      'Drinks',
                      style: detailSubitleTextStyle,
                    ),
                  ),
                  SizedBox(height: 8),
                  _buildMenuCardView(restaurants.menus.drinks),
                  SizedBox(height: _paddingValue),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _buildMenuCardView(var data) {
    return Container(
      height: 175,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          SizedBox(width: _paddingValue),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: data.length,
            separatorBuilder: (context, index) {
              return SizedBox(width: 5);
            },
            itemBuilder: (context, index) {
              return MenuCard(menuName: data[index].name);
            },
          ),
          SizedBox(width: _paddingValue)
        ],
      ),
    );
  }
}
