import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPreferences;
  PreferencesHelper({
    required this.sharedPreferences,
  });

  static const DAILY_NOTIF = 'DAILY_NOTIF';
  static const FIRST_LOGIN = 'FIRST_LOGIN';

  Future<bool> get isDailyNotifOn async {
    final prefs = await sharedPreferences;
    return prefs.getBool(DAILY_NOTIF) ?? false;
  }

  void setDailyNotifOn(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(DAILY_NOTIF, value);
  }

  Future<bool> get isFirstLogin async {
    final prefs = await sharedPreferences;
    return prefs.getBool(FIRST_LOGIN) ?? true;
  }

  void setNotFirstLogin() async {
    final prefs = await sharedPreferences;
    prefs.setBool(FIRST_LOGIN, false);
  }
}
