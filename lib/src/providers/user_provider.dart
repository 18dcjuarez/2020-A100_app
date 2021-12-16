import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:gestion/src/data/services/user_service.dart';
import 'package:gestion/src/models/user_model.dart';
import 'package:http/http.dart';

class UserProvider extends ChangeNotifier {
  UserModel? user;

  Future<void> getUser() async {
    final Response? resp = await UserService().getUser();
    if (resp != null) {
      final decodedResponse = jsonDecode(utf8.decode(resp.bodyBytes)) as Map;
      this.user = UserModel.fromMap(decodedResponse);
    }
    notifyListeners();
  }
}
