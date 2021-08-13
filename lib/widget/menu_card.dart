import 'package:flutter/material.dart';

import 'package:restaurant_apps/theme/typography.dart';

class MenuCard extends StatelessWidget {
  final String menuName;

  const MenuCard({
    Key? key,
    required this.menuName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 175,
      width: 200,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0),
                  ),
                  child: Image.asset(
                    'assets/images/menu_bg.jpg',
                    height: 100,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 35,
                  right: 4,
                  left: 4,
                  child: Text(
                    menuName,
                    style: placeNameTextStyle,
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    menuName,
                    style: menuNameTextStyle,
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                  ),
                  Text(
                    'IDR 20.000',
                    style: detailContentTextStyle,
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
