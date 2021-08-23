import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:restaurant_apps/model/restaurant_list_model.dart';
import 'package:restaurant_apps/provider/database_provider.dart';
import 'package:restaurant_apps/theme/color.dart';

class FavoriteButton extends StatefulWidget {
  final double size;
  final Restaurant resto;

  FavoriteButton({
    Key? key,
    required this.size,
    required this.resto,
  }) : super(key: key);

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<bool>(
          future: provider.isFavorite(widget.resto.id),
          builder: (context, snapshot) {
            var isFavorited = snapshot.data ?? false;
            return GestureDetector(
              onTap: isFavorited
                  ? () => provider.unfavoritedResto(widget.resto.id)
                  : () => provider.addFavorite(widget.resto),
              child: Container(
                width: widget.size,
                height: widget.size,
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
                    isFavorited ? Icons.favorite : Icons.favorite_border,
                    color: isFavorited ? redColor : redColor.withOpacity(.3),
                    size: widget.size * 0.8,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
