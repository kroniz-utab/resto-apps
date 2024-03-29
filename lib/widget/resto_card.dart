import 'package:flutter/material.dart';
import 'package:restaurant_apps/helper/navigation_helper.dart';
import 'package:restaurant_apps/layout/detail_resto.dart';

import 'package:restaurant_apps/model/restaurant_list_model.dart';
import 'package:restaurant_apps/theme/color.dart';
import 'package:restaurant_apps/theme/typography.dart';
import 'package:restaurant_apps/widget/favorite_button.dart';

class RestoCard extends StatelessWidget {
  final Restaurant resto;

  const RestoCard({
    Key? key,
    required this.resto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: blackColor.withOpacity(.4),
            blurRadius: 3,
            offset: Offset(3, 0),
          ),
        ],
      ),
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Navigation.intentWithData(
                DetailResto.routeName,
                resto.id,
              );
            },
            child: Stack(
              children: [
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/images/placeholder.jpg',
                      image:
                          'https://restaurant-api.dicoding.dev/images/medium/${resto.pictureId}',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  decoration: new BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        blackColor.withOpacity(.5),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.4, 0.8],
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 60,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 2.0,
                          horizontal: 8.0,
                        ),
                        decoration: BoxDecoration(
                          color: blackColor.withOpacity(.25),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.star,
                              color: starColor,
                              size: 18,
                            ),
                            Text(
                              '${resto.rating}',
                              style: ratingTextStyle,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 160,
                  right: 8,
                  left: 8,
                  bottom: 8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        resto.name,
                        style: placeNameTextStyle,
                        maxLines: 2,
                        overflow: TextOverflow.clip,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.place,
                            color: whiteColor,
                            size: 18,
                          ),
                          Text(
                            resto.city,
                            style: locationOnCardTextStyle,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: FavoriteButton(
                size: 30,
                resto: resto,
              ),
            ),
          )
        ],
      ),
    );
  }
}
