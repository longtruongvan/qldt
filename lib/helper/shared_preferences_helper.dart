import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const themeModeKey = 'themeModeKey';
  static const languageKey = 'languageKey';

  static Future<void> saveValue(String key, int value) async {
    final pref = await SharedPreferences.getInstance();
    pref.setInt(key, value);
  }

  static Future<int?> getValue(String key) async {
    final pref = await SharedPreferences.getInstance();
    return pref.getInt(key);
  }
}
