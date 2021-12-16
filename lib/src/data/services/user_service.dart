import 'package:gestion/src/data/repositories/user_repository.dart';
import 'package:http/http.dart';

class UserService {
  Future<Response?> getUser() async {
    try {
      return await UserRepository().getUser();
    } catch (e) {
      print(e);
      return null;
    }
  }
}
