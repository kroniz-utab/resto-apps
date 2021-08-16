import 'package:flutter/foundation.dart';

import 'package:restaurant_apps/api/api_service.dart';
import 'package:restaurant_apps/model/restaurant_search_model.dart';

enum SearchResultState { Loading, NoData, HasData, Error }

class SearchProvider extends ChangeNotifier {
  final ApiServices apiServices;
  final String query;

  SearchProvider({
    required this.apiServices,
    required this.query,
  });

  late String _message = '';
  late SearchResultState _state = SearchResultState.Loading;
  late RestoSearchModel _result;

  String get message => _message;
  SearchResultState get state => _state;
  RestoSearchModel get result => _result;
}
