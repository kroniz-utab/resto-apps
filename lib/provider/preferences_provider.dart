import 'package:flutter/foundation.dart';

import 'package:restaurant_apps/helper/preferences_helper.dart';

class PreferencesProvider extends ChangeNotifier {
  final PreferencesHelper preferencesHelper;

  PreferencesProvider({
    required this.preferencesHelper,
  }) {
    _getNotifOn();
    _getFirstLogin();
  }

  bool _isNotifOn = false;
  bool get isNotifOn => _isNotifOn;

  bool _isFirstLogin = true;
  bool get isFirstLogin => _isFirstLogin;

  void _getNotifOn() async {
    _isNotifOn = await preferencesHelper.isDailyNotifOn;
    notifyListeners();
  }

  void enableNotifOn(bool value) async {
    preferencesHelper.setDailyNotifOn(value);
    _getNotifOn();
  }

  void _getFirstLogin() async {
    _isFirstLogin = await preferencesHelper.isFirstLogin;
    notifyListeners();
  }

  void setNotFirstLogin() async {
    preferencesHelper.setNotFirstLogin();
    _getFirstLogin();
  }
}
