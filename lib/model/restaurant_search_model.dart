import 'package:restaurant_apps/model/restaurant_list_model.dart';

class RestoSearchModel {
  RestoSearchModel({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  bool error;
  int founded;
  List<Restaurant> restaurants;

  factory RestoSearchModel.fromJson(Map<String, dynamic> json) =>
      RestoSearchModel(
        error: json["error"],
        founded: json["founded"],
        restaurants: List<Restaurant>.from(
            json["restaurants"].map((x) => Restaurant.fromJson(x))),
      );
}
