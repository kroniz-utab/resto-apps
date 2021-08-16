import 'package:flutter/foundation.dart';
import 'package:restaurant_apps/api/api_service.dart';
import 'package:restaurant_apps/model/restaurant_details.dart';

enum DetailResultState { Loading, NoData, HasData, Error }

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiServices apiServices;
  final String id;

  RestaurantDetailProvider({
    required this.apiServices,
    required this.id,
  }) {
    _fetchDetailRestaurant();
  }

  late String _message = '';
  late DetailResultState _state = DetailResultState.Loading;
  late RestaurantDetailModel _restaurantDetail;

  DetailResultState get state => _state;
  String get message => _message;
  RestaurantDetailModel get restaurantDetail => _restaurantDetail;

  Future<dynamic> _fetchDetailRestaurant() async {
    try {
      _state = DetailResultState.Loading;
      notifyListeners();
      final restoDetail = await apiServices.restoDetail(id);
      if (restoDetail.error) {
        _state = DetailResultState.NoData;
        notifyListeners();
        return _message = restoDetail.message;
      } else {
        _state = DetailResultState.HasData;
        notifyListeners();
        return _restaurantDetail = restoDetail;
      }
    } catch (e) {
      _state = DetailResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
