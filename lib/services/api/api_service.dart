import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:restaurant_apps/model/restaurant_details.dart';
import 'package:restaurant_apps/model/restaurant_list_model.dart';
import 'package:restaurant_apps/model/restaurant_search_model.dart';

class ApiServices {
  static final String baseUrl = 'https://restaurant-api.dicoding.dev/';
  static final String apiKeys = '12345';

  Future<RestaurantsListModel> allRestaurantList() async {
    final String _completeUri = baseUrl + 'list';
    final http.Response response = await http.get(Uri.parse(_completeUri));

    if (response.statusCode == 200) {
      return RestaurantsListModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Restaurant List');
    }
  }

  Future<RestaurantDetailModel> restoDetail(String id) async {
    final String _completeUri = baseUrl + 'detail/$id';
    final http.Response response = await http.get(Uri.parse(_completeUri));

    if (response.statusCode == 200) {
      return RestaurantDetailModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Restaurant Detail with id : $id');
    }
  }

  Future<RestoSearchModel> restoSearch(String query) async {
    final String _completeUri = baseUrl + 'search?q=$query';
    final http.Response response = await http.get(Uri.parse(_completeUri));

    if (response.statusCode == 200) {
      return RestoSearchModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to search with existing queries.');
    }
  }
}
