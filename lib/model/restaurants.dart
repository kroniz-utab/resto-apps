import 'dart:convert';

import 'package:restaurant_apps/model/menus.dart';

class Restaurants {
  late String id;
  late String name;
  late String description;
  late String pictureId;
  late String city;
  late double rating;
  late Menus menus;

  Restaurants({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.menus,
  });

  Restaurants.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    pictureId = json['pictureId'];
    city = json['city'];
    rating = json['rating'].toDouble();
    menus = Menus.fromJson(json['menus']);
  }
}

List<Restaurants> parseAllRestaurant(String? json) {
  if (json == null) return [];

  final List parsed = jsonDecode(json)["restaurants"];
  return parsed.map((json) => Restaurants.fromJson(json)).toList();
}

List<Restaurants> parseBestRestaurant(String? json) {
  if (json == null) return [];

  final List parsed = jsonDecode(json)["restaurants"];
  List<Restaurants> bestRestaurants =
      parsed.map((json) => Restaurants.fromJson(json)).toList();
  bestRestaurants.sort((value2, value1) {
    return value1.rating.compareTo(value2.rating);
  });
  return bestRestaurants.sublist(0, 4);
}
