import 'package:flutter/material.dart';
import 'package:restaurant_apps/helper/navigation_helper.dart';
import 'package:restaurant_apps/layout/detail_resto.dart';

import 'package:restaurant_apps/model/restaurant_list_model.dart';
import 'package:restaurant_apps/theme/color.dart';
import 'package:restaurant_apps/theme/typography.dart';
import 'package:restaurant_apps/widget/favorite_button.dart';

class RestoList extends StatelessWidget {
  final Restaurant resto;

  const RestoList({
    Key? key,
    required this.resto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: blackColor.withOpacity(.25),
              blurRadius: 3,
              offset: Offset(1, 3),
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
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: FadeInImage.assetNetwork(
                        placeholder: 'assets/images/placeholder.jpg',
                        image:
                            'https://restaurant-api.dicoding.dev/images/medium/${resto.pictureId}',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            blackColor.withOpacity(.5),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0.4, 0.8],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 90,
                      bottom: 8,
                      right: 8,
                      left: 8,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            resto.name,
                            style: placeNameTextStyle,
                            maxLines: 1,
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
                              SizedBox(width: 2),
                              Text(
                                resto.city,
                                style: locationOnCardTextStyle,
                              ),
                              SizedBox(width: 16),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: starColor,
                                    size: 18,
                                  ),
                                  SizedBox(width: 2),
                                  Text(
                                    resto.rating.toString(),
                                    style: locationOnCardTextStyle,
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
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
      ),
    );
  }
}
