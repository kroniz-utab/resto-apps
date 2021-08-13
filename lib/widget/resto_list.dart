import 'package:flutter/material.dart';

import 'package:restaurant_apps/theme/color.dart';
import 'package:restaurant_apps/theme/typography.dart';

class RestoList extends StatelessWidget {
  final String restoRating;
  final String restoLocation;
  final String restoName;
  final String imgUrl;

  const RestoList({
    Key? key,
    required this.restoRating,
    required this.restoLocation,
    required this.restoName,
    required this.imgUrl,
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
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/images/placeholder.jpg',
                      image: imgUrl,
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
                          restoName,
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
                              restoLocation,
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
                                  restoRating,
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
          ],
        ),
      ),
    );
  }
}
