import 'package:flutter/material.dart';
import 'package:restaurant_apps/theme/color.dart';

class FavoriteButton extends StatefulWidget {
  final double size;
  final bool isFavorite;
  FavoriteButton({
    Key? key,
    required this.size,
    required this.isFavorite,
  }) : super(key: key);

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState(
        isFavoritePassed: isFavorite,
        sizePassed: size,
      );
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavoritePassed;
  double sizePassed;
  _FavoriteButtonState({
    required this.isFavoritePassed,
    required this.sizePassed,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isFavoritePassed = !isFavoritePassed;
        });
      },
      child: Container(
        width: sizePassed,
        height: sizePassed,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Color(0x3f000000),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
          color: whiteColor,
        ),
        child: Center(
          child: Icon(
            isFavoritePassed ? Icons.favorite : Icons.favorite_border,
            color: isFavoritePassed ? redColor : redColor.withOpacity(.3),
            size: 25 * 0.8,
          ),
        ),
      ),
    );
  }
}
