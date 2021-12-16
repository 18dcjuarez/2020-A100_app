import 'package:gestion/src/data/enum/shared_preferences_key.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesRepository {
  SharedPreferencesRepository._internal();

  static SharedPreferencesRepository get instance => _instance;

  static SharedPreferencesRepository _instance =
      SharedPreferencesRepository._internal();

  Future<String?> getData(SharedPreferencesKey key) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString(key.key);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<bool> saveData(SharedPreferencesKey key, String value) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return await prefs.setString(key.key, value);
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> deleteData(SharedPreferencesKey key) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return await prefs.remove(key.key);
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> deleteKeys() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      for (SharedPreferencesKey i in SharedPreferencesKey.values) {
        await prefs.remove(i.key);
      }
      return;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
