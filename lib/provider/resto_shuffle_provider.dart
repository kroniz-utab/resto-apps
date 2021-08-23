import 'package:flutter/foundation.dart';
import 'package:restaurant_apps/api/api_service.dart';
import 'package:restaurant_apps/model/restaurant_list_model.dart';

enum ResultShuffleState { Loading, NoData, HasData, Error }

class RestaurantShuffleProvider extends ChangeNotifier {
  final ApiServices apiServices;

  RestaurantShuffleProvider({
    required this.apiServices,
  }) {
    _fetchAllRestaurants();
  }

  late String _message = '';
  late ResultShuffleState _state = ResultShuffleState.Loading;
  late List<Restaurant> _restaurantList;

  ResultShuffleState get state => _state;
  String get message => _message;
  List<Restaurant> get restaurantList => _restaurantList;

  Future<dynamic> _fetchAllRestaurants() async {
    try {
      _state = ResultShuffleState.Loading;
      notifyListeners();
      final resto = await apiServices.allRestaurantList();
      if (resto.restaurants.isEmpty) {
        _state = ResultShuffleState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultShuffleState.HasData;
        notifyListeners();
        final List<Restaurant> restoList = resto.restaurants;
        restoList.shuffle();
        return _restaurantList = restoList;
      }
    } catch (e) {
      _state = ResultShuffleState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
