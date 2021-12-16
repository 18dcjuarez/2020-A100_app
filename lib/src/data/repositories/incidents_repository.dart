import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gestion/src/data/enum/shared_preferences_key.dart';
import 'package:gestion/src/data/repositories/shared_preferences_repository.dart';
import 'package:http/http.dart' as http;

class IncidentsRepository {
  Future<http.Response?> registerPermisoEconomico(
      Map<String, dynamic> body) async {
    final String _path = '${dotenv.env['API_URL']}/api/permiso_economico/add/';
    try {
      final token = await SharedPreferencesRepository.instance
          .getData(SharedPreferencesKey.TOKEN);
      Map<String, String> requestHeaders = {
        'Accept': 'application/json',
        'Authorization': 'JWT $token'
      };
      final Uri url = Uri.parse(_path);
      return await http.post(url, headers: requestHeaders, body: body);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<http.Response?> registerRetardo(Map<String, dynamic> body) async {
    final String _path = '${dotenv.env['API_URL']}/api/retardo/add/';
    try {
      final token = await SharedPreferencesRepository.instance
          .getData(SharedPreferencesKey.TOKEN);
      Map<String, String> requestHeaders = {
        'Accept': 'application/json',
        'Authorization': 'JWT $token'
      };
      final Uri url = Uri.parse(_path);
      return await http.post(url, headers: requestHeaders, body: body);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<http.Response?> getAllIncidents(String route) async {
    final String _path = '${dotenv.env['API_URL']}/api/$route';
    try {
      final token = await SharedPreferencesRepository.instance
          .getData(SharedPreferencesKey.TOKEN);
      Map<String, String> requestHeaders = {
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
