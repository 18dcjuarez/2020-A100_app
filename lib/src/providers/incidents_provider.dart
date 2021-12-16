import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:gestion/src/data/services/incidents_service.dart';
import 'package:http/http.dart';

class IncidentsProvider with ChangeNotifier {
  List<String> incidentsType = [
    'Permiso económico',
    'Cambio de horario',
    'Reposición de horas',
    'Retardo',
    'Omisión de marcaje'
  ];
  String selectedIncidentType = 'Permiso económico';
  List<String> incidentsPaths = [
    'permisos_economicos/',
    'retardos/',
    'omisiones/',
    'cambios_horario/',
    'reposiciones_horas/'
  ];

  String tipoRetardo = 'Mayor';
  List<String> tipoRetardoList = ['Mayor', 'Menor'];

  int totalIncidents = 0;

  List<dynamic> incidents = [];

  Future<Response?> registerIncident(Map<String, dynamic> body) async {
    final Response? resp =
        await IncidentesService().registerPermisoEconomico(body);
    return resp;
  }

  Future<Response?> registerRetardo(Map<String, dynamic> body) async {
    final Response? resp = await IncidentesService().registerRetardo(body);
    return resp;
  }

  Future<void> getAllIncidentsTotal() async {
    totalIncidents = 0;
    incidentsPaths.map((path) async {
      final pe = await IncidentesService().getAllIncidents(path);
      List<dynamic> decodedResponse = [];
      if (pe != null && pe.statusCode == 200) {
        decodedResponse = jsonDecode(utf8.decode(pe.bodyBytes)) as List;
      }
      // List<dynamic> auxPending = [];
      // decodedResponse.map((e) {
      //   if (e['estatus_solicitud'] == "Solicitado") {
      //     auxPending.add(e);
      //   }
      // }).toList();
      // print('AUXPENDING ${auxPending.length}');
      totalIncidents += decodedResponse.length;
    }).toList();
    notifyListeners();
  }

  Future<void> getIncidentsType(String path) async {
    final pe = await IncidentesService().getAllIncidents(path);
    List<dynamic> decodedResponse = [];
    if (pe != null && pe.statusCode == 200) {
      decodedResponse = jsonDecode(utf8.decode(pe.bodyBytes)) as List;
    }
    // List<dynamic> auxPending = [];
    // decodedResponse.map((e) {
    //   if (e['estatus_solicitud'] == "Solicitado") {
    //     auxPending.add(e);
    //   }
    // }).toList();
    // print('AUXPENDING ${auxPending.length}');
    incidents = decodedResponse;
    notifyListeners();
  }
}
