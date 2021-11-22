import 'package:flutter/foundation.dart';

class IncidentsProvider with ChangeNotifier {
  List<String> incidentsType = ['Enfermedad', 'Día económico', 'Retardo'];
  String selectedIncidentType = 'Enfermedad';
}
