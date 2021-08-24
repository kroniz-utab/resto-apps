import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:restaurant_apps/helper/datetime_helper.dart';
import 'package:restaurant_apps/services/background/background_service.dart';

class SchedulingProvider extends ChangeNotifier {
  bool _isNotifOn = false;
  bool get isNotifOn => _isNotifOn;

  Future<bool> dailyNotifOn(bool value) async {
    _isNotifOn = value;
    if (isNotifOn) {
      print('Daily Notification is On!');
      notifyListeners();
      return await AndroidAlarmManager.periodic(
        Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      print('Daily notification is turn off');
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}
