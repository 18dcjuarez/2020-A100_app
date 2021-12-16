import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gestion/src/data/enum/shared_preferences_key.dart';
import 'package:gestion/src/data/repositories/shared_preferences_repository.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  Future<http.Response?> getUser() async {
    final String _path = '${dotenv.env['API_URL']}/auth/users/me/';
    try {
      final token = await SharedPreferencesRepository.instance
          .getData(SharedPreferencesKey.TOKEN);
      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'JWT $token'
      };
      final Uri url = Uri.parse(_path);
      return await http.get(url, headers: requestHeaders);
    } catch (e) {
      print(e);
      return null;
    }
  }
}
