import 'package:shared_preferences/shared_preferences.dart';

class UserSharedPreferences {
  static late SharedPreferences _preferences;
  static const signInKey = 'status';
  static const tokenKey = 'token';
  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setLoginStatus(bool isSignedIn) async =>
      await _preferences.setBool(signInKey, isSignedIn);

  static bool getSignInStatus() => _preferences.getBool(signInKey) ?? false;

  static Future setAccessToken(String accessToken) async =>
      await _preferences.setString(tokenKey, accessToken);

  static String getAccessToken() => _preferences.getString(tokenKey)!;
}

//import 'package:shared_preferences/shared_preferences.dart';
//class UserSharedPreferences {
//   static const signInKey = 'status';
//   static const tokenKey = 'token';
//   setSignStatus(bool isSignedIn) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setBool(signInKey, isSignedIn);
//   }
//   Future<bool> getSignInStatus() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getBool(signInKey) ?? false;
//   }
//   setAccessToken(String accessToken) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setString(tokenKey, accessToken);
//   }
//   Future<String> getAccessToken() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getString(tokenKey) ?? '';
//   }
// }
