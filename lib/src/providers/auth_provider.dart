import 'package:flutter/foundation.dart';
import 'package:gestion/src/data/services/auth_service.dart';
import 'package:gestion/src/providers/incidents_provider.dart';
import 'package:gestion/src/providers/user_provider.dart';
import 'package:http/http.dart';

class AuthProvider with ChangeNotifier {
  bool emailCheck = false;
  bool passwordCheck = false;
  bool _loading = false;

  bool get loading => _loading;

  Future<Response> login(String email, String password) async {
    final body = {'email': email, 'password': password};
    final resp = await AuthService().login(body);
    await UserProvider().getUser();
    await IncidentsProvider().getAllIncidentsTotal();
    notifyListeners();
    return resp!;
  }

  Future<bool?> logout() async {
    final bool? resp = await AuthService().logout();
    return resp;
  }

  Future<bool?> verify() async {
    final bool? resp = await AuthService().verify();
    return resp;
  }

  Future<Response?> passwordRestore() async {
    final Response? resp = await AuthService().passwordRestore();
    return resp;
  }
}
