import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:restaurant_apps/helper/navigation_helper.dart';
import 'package:restaurant_apps/model/restaurant_list_model.dart';
import 'package:rxdart/rxdart.dart';

final selectNotiicationSubject = BehaviorSubject<String>();

class NotificationHelper {
  static NotificationHelper? _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initSettingAndroid = AndroidInitializationSettings('app_icon');

    var initSettingIOS = IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    var initSettings = InitializationSettings(
      android: initSettingAndroid,
      iOS: initSettingIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onSelectNotification: (String? payload) async {
        if (payload != null) {
          print('notification payload ' + payload);
        }
        selectNotiicationSubject.add(payload ?? 'empty payload');
      },
    );
  }

  Future<String> _downloadAndSafeFile(String url, String fileName) async {
    var directory = await getApplicationDocumentsDirectory();
    var filePath = '${directory.path}/$fileName';
    var response = await http.get(Uri.parse(url));
    var file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  Future<void> showNotification(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
    RestaurantsListModel resto,
  ) async {
    Restaurant restaurant =
        resto.restaurants[Random().nextInt(resto.restaurants.length)];
    var _channelId = '1';
    var _channelName = 'channel1';
    var _channelDescription = 'Resto Pilihan Hari ini!';

    var titleNotification =
        '${restaurant.name} jadi pilihan bagus hari ini lo!';
    var bodyNotification =
        'resto ini berada di ${restaurant.city} dan memiliki rating ${restaurant.rating} lhoo!';

    var bigPicturePath = await _downloadAndSafeFile(
      'https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}',
      '${restaurant.name}_medium',
    );

    var largeIconPath = await _downloadAndSafeFile(
      'https://uxwing.com/wp-content/themes/uxwing/download/20-food-and-drinks/food.png',
      'largeIcon',
    );

    var bigPictureStyleInformation = BigPictureStyleInformation(
      FilePathAndroidBitmap(bigPicturePath),
      largeIcon: FilePathAndroidBitmap(largeIconPath),
      contentTitle: titleNotification,
      htmlFormatContentTitle: true,
      summaryText: bodyNotification,
      htmlFormatSummaryText: true,
    );

    var androidChannelSpecifics = AndroidNotificationDetails(
      _channelId,
      _channelName,
      _channelDescription,
      importance: Importance.max,
      ticker: 'ticker',
      styleInformation: bigPictureStyleInformation,
    );

    var platformChannelSpecifics = NotificationDetails(
      android: androidChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      titleNotification,
      bodyNotification,
      platformChannelSpecifics,
      payload: json.encode(restaurant.toJson()),
    );
  }

  void configureSelectNotificationSubject(String route) {
    selectNotiicationSubject.stream.listen((String payload) async {
      var data = Restaurant.fromJson(json.decode(payload));
      Navigation.intentWithData(route, data.id);
    });
  }
}
