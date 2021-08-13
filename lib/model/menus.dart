import 'package:restaurant_apps/model/drinks.dart';
import 'package:restaurant_apps/model/foods.dart';

class Menus {
  late List<Foods> foods;
  late List<Drinks> drinks;

  Menus({
    required this.foods,
    required this.drinks,
  });

  Menus.fromJson(Map<String, dynamic> json) {
    if (json['foods'] != null) {
      foods = <Foods>[];
      json['foods'].forEach((data) {
        foods.add(new Foods.fromJson(data));
      });
    }
    if (json['drinks'] != null) {
      drinks = <Drinks>[];
      json['drinks'].forEach((data) {
        drinks.add(new Drinks.fromJson(data));
      });
    }
  }
}
