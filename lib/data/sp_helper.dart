import 'package:shared_preferences/shared_preferences.dart';

class SpHelper {
  SpHelper._();
  static final spHelper = SpHelper._();

  SharedPreferences sharedPreferences;

  initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  setToken(String token) {
    sharedPreferences.setString('token', token);
  }

  String getToken() => sharedPreferences.getString('token');
}
