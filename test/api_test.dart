import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_apps/model/restaurant_list_model.dart';
import 'package:restaurant_apps/model/restaurant_search_model.dart';
import 'package:restaurant_apps/services/api/api_service.dart';

import 'api_test.mocks.dart';

@GenerateMocks([ApiServices])
void main() {
  group('Restaurant API test', () {
    Restaurant resto = Restaurant(
      id: 'fasad23',
      name: 'Resto Baru Coba',
      description: 'lorem ipsum',
      pictureId: '515',
      city: 'Batu',
      rating: 4.5,
    );

    MockApiServices apiServices = MockApiServices();

    test('Parsing JSON Test', () {
      var result = Restaurant.fromJson(resto.toJson());

      expect(
        result,
        equals(
          Restaurant(
            id: resto.id,
            name: resto.name,
            description: 'apaan aja boleh',
            pictureId: resto.pictureId,
            city: resto.city,
            rating: 4.2,
          ),
        ),
      );
    });

    test('Fetch list of restaurant test', () async {
      when(apiServices.allRestaurantList()).thenAnswer((_) async {
        return RestaurantsListModel(
          error: false,
          message: 'success',
          count: 1,
          restaurants: [resto],
        );
      });
      expect(
          await apiServices.allRestaurantList(), isA<RestaurantsListModel>());
    });

    test('Fetch restaurant list from search test', () async {
      when(apiServices.restoSearch(resto.name)).thenAnswer((_) async {
        return RestoSearchModel(error: false, founded: 1, restaurants: [resto]);
      });
      expect(
          await apiServices.restoSearch(resto.name), isA<RestoSearchModel>());
    });
  });
}
