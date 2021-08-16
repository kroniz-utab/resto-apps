import 'package:flutter/foundation.dart';
import 'package:restaurant_apps/api/api_service.dart';
import 'package:restaurant_apps/model/restaurant_list_model.dart';

enum ResultListState { Loading, NoData, HasData, Error }

class RestaurantListProvider extends ChangeNotifier {
  final ApiServices apiServices;

  RestaurantListProvider({
    required this.apiServices,
  }) {
    _fetchAllRestaurants();
  }

  late String _message = '';
  late ResultListState _state = ResultListState.Loading;
  late RestaurantsListModel _restaurantList;

  ResultListState get state => _state;
  String get message => _message;
  RestaurantsListModel get restaurantList => _restaurantList;

  Future<dynamic> _fetchAllRestaurants() async {
    try {
      _state = ResultListState.Loading;
      notifyListeners();
      final resto = await apiServices.allRestaurantList();
      if (resto.restaurants.isEmpty) {
        _state = ResultListState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultListState.HasData;
        notifyListeners();
        return _restaurantList = resto;
      }
    } catch (e) {
      _state = ResultListState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
