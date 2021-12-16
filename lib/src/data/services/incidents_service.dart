import 'package:gestion/src/data/repositories/incidents_repository.dart';
import 'package:http/http.dart';

class IncidentesService {
  Future<Response?> registerPermisoEconomico(Map<String, dynamic> body) async {
    try {
      return await IncidentsRepository().registerPermisoEconomico(body);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Response?> registerRetardo(Map<String, dynamic> body) async {
    try {
      return await IncidentsRepository().registerRetardo(body);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Response?> getAllIncidents(String route) async {
    try {
      return await IncidentsRepository().getAllIncidents(route);
    } catch (e) {
      print(e);
      return null;
    }
  }
}