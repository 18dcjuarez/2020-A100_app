import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gestion/src/data/enum/shared_preferences_key.dart';
import 'package:gestion/src/data/repositories/shared_preferences_repository.dart';
import 'package:http/http.dart' as http;

class AuthRepository {
  final String _path = '${dotenv.env['API_URL']}';

  Future<http.Response?> login(Map<String, dynamic> body) async {
    try {
      final Uri url = Uri.parse('$_path/auth/jwt/create/');
      final r = await http.post(url, body: body);
      return r;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<bool?> verify() async {
    try {
      final token = await SharedPreferencesRepository.instance
          .getData(SharedPreferencesKey.TOKEN);
      if (token == null) return false;
      final body = {'token': token};
      final Uri url = Uri.parse('$_path/auth/jwt/verify/');
      final r = await http.post(url, body: body);
      if (r.statusCode == 200 || r.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<bool?> logout() async {
    try {
      final token = await SharedPreferencesRepository.instance
          .getData(SharedPreferencesKey.TOKEN);
      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'JWT $token'
      };
      final Uri url = Uri.parse('$_path/auth/token/logout/');
      final r = await http.post(url, headers: requestHeaders);
      await SharedPreferencesRepository.instance.deleteKeys();
      return true;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<http.Response?> passwordRestore() async {
    try {
      final body = {'email': '18dave2@gmail.com'};
      final Uri url = Uri.parse('$_path/auth/users/reset_password/');
      return await http.post(url, body: body);
    } catch (e) {
      print(e);
      return null;
    }
  }
}
