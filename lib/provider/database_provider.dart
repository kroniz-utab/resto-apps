import 'package:flutter/foundation.dart';

import 'package:restaurant_apps/helper/database_helper.dart';
import 'package:restaurant_apps/model/restaurant_list_model.dart';

enum DatabaseResultState { Loading, NoData, HasData, Error }

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({
    required this.databaseHelper,
  }) {
    _getFavorite();
  }

  late DatabaseResultState _state;
  DatabaseResultState get state => _state;

  String _message = '';
  String get message => _message;

  List<Restaurant> _favorite = [];
  List<Restaurant> get favorites => _favorite;

  void _getFavorite() async {
    _favorite = await databaseHelper.getFavorite();
    if (_favorite.length > 0) {
      _state = DatabaseResultState.HasData;
    } else {
      _state = DatabaseResultState.NoData;
      _message = 'You did\'nt have any favorite restaurant :(';
    }
    notifyListeners();
  }

  void addFavorite(Restaurant resto) async {
    try {
      await databaseHelper.insertFavoriteResto(resto);
      _getFavorite();
    } catch (e) {
      _state = DatabaseResultState.Error;
      _message = 'Error : $e';
      notifyListeners();
    }
  }

  Future<bool> isFavorite(String id) async {
    final favoritedResto = await databaseHelper.getFavoriteRestoById(id);
    return favoritedResto.isNotEmpty;
  }

  void unfavoritedResto(String id) async {
    try {
      await databaseHelper.unfavoritedRestaurant(id);
      _getFavorite();
    } catch (e) {
      _state = DatabaseResultState.Error;
      _message = 'Error : $e';
      notifyListeners();
    }
  }
}
