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
  String selectedIncidentPath = 'permisos_economicos/';

  String tipoRetardo = 'Mayor';
  List<String> tipoRetardoList = ['Mayor', 'Menor'];

  String tipoOmisionMarcaje = 'Entrada';
  List<String> tipoOmisionMarcajeList = ['Entrada', 'Salida'];

  String selectedApprovePath = 'aprobaciones_permisos_economicos/';
  List<String> selectedApproveList = [
    'aprobaciones_permisos_economicos/',
    'aprobaciones_retardos/',
    'aprobaciones_omisiones/',
    'aprobaciones_cambios_horario/',
    'aprobaciones_reposiciones_horas/'
  ];

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

  Future<Response?> registerOmisionMarcaje(Map<String, dynamic> body) async {
    final Response? resp =
        await IncidentesService().registerOmisionMarcaje(body);
    return resp;
  }

  Future<Response?> registerCambioHorario(Map<String, dynamic> body) async {
    final Response? resp =
        await IncidentesService().registerCambioHorario(body);
    return resp;
  }

  Future<dynamic> registerReposicionHoras(Map<String, dynamic> body) async {
    final dynamic resp =
        await IncidentesService().registerReposicionHoras(body);
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
      // incidents.addAll(decodedResponse);
      // print('DECODED $decodedResponse');
      totalIncidents += decodedResponse.length;
    }).toList();
    // print('INCIDENTS $incidents');
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

  Future<void> getIncidentsToApprove(String path) async {
    final pe = await IncidentesService().getIncidentsToAprrove(path);
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

  Future<Response?> incidentAction(String path) async {
    final dynamic resp = await IncidentesService().incidentAction(path);
    return resp;
  }
}
