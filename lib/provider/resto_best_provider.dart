import 'package:flutter/foundation.dart';
import 'package:restaurant_apps/model/restaurant_list_model.dart';
import 'package:restaurant_apps/services/api/api_service.dart';

enum ResultBestState { Loading, NoData, HasData, Error }

class RestaurantBestProvider extends ChangeNotifier {
  final ApiServices apiServices;

  RestaurantBestProvider({
    required this.apiServices,
  }) {
    _fetchBestRestaurants();
  }

  late String _message = '';
  late ResultBestState _state = ResultBestState.Loading;
  late List<Restaurant> _restaurant;

  ResultBestState get state => _state;
  String get message => _message;
  List<Restaurant> get restoBest => _restaurant;

  Future<dynamic> _fetchBestRestaurants() async {
    try {
      _state = ResultBestState.Loading;
      notifyListeners();
      final resto = await apiServices.allRestaurantList();
      if (resto.restaurants.isEmpty) {
        _state = ResultBestState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultBestState.HasData;
        notifyListeners();
        final List<Restaurant> restoList = resto.restaurants;
        restoList.sort((value1, value2) {
          return value2.rating.compareTo(value1.rating);
        });
        return _restaurant = restoList.sublist(0, 4);
      }
    } catch (e) {
      _state = ResultBestState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
