import 'dart:convert';

import 'package:gestion/src/data/enum/shared_preferences_key.dart';
import 'package:gestion/src/data/repositories/auth_repository.dart';
import 'package:gestion/src/data/repositories/shared_preferences_repository.dart';
import 'package:http/http.dart';

class AuthService {
  Future<Response?> login(Map<String, String> body) async {
    try {
      final Response? res = await AuthRepository().login(body);
      await SharedPreferencesRepository.instance.deleteKeys();
      if (res!.statusCode == 200 || res.statusCode == 201) {
        final decodedResponse = jsonDecode(utf8.decode(res.bodyBytes)) as Map;
        await SharedPreferencesRepository.instance
            .saveData(SharedPreferencesKey.TOKEN, decodedResponse['access']);
      }
      return res;
    } catch (ex) {
      print(ex);
      return null;
    }
  }

  Future<bool?> verify() async {
    try {
      final bool? res = await AuthRepository().verify();
      return res;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<bool?> logout() async {
    try {
      final bool? res = await AuthRepository().logout();
      return res;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Response?> passwordRestore() async {
    try {
      final Response? res = await AuthRepository().passwordRestore();
      return res;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
