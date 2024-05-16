import 'package:shared_preferences/shared_preferences.dart';

class PreferenceManager {
  late SharedPreferences preferences;
  static const String extraToken = 'extra_token';

  Future<void> setLoginUser(String token) async {
    preferences = await SharedPreferences.getInstance();
    preferences.setString(extraToken, token);
  }

  Future<String> getLoginUser() async {
    preferences = await SharedPreferences.getInstance();
    return preferences.getString(extraToken) ?? '';
  }

  Future<void> logOutUser() async {
    preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }
}
