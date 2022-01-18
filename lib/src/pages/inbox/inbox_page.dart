import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gestion/src/pages/incidents_history/widgets/incidentes_history_available_item_widget.dart';
import 'package:gestion/src/pages/incidents_history/widgets/incidents_history_item_widget.dart';
import 'package:gestion/src/providers/incidents_provider.dart';
import 'package:gestion/src/widgets/incidencias_bottom_menu.dart';
import 'package:gestion/src/widgets/incidencias_widgets.dart';
import 'package:gestion/theme.dart';
import 'package:provider/provider.dart';

class InboxPage extends StatefulWidget {
  static const String id = "/inbox";
  const InboxPage({Key? key}) : super(key: key);

  @override
  State<InboxPage> createState() => _InboxPageState();
}

class _InboxPageState extends State<InboxPage> {
  @override
  void initState() {
    Future.microtask(() => context
        .read<IncidentsProvider>()
        .getIncidentsToApprove('aprobaciones_permisos_economicos/'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final IncidentsProvider? _incidentsProviderWatcher =
        context.watch<IncidentsProvider>();
    final IncidentsProvider _incidentsProviderReader =
        context.read<IncidentsProvider>();
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: double.infinity,
              height: 50.h,
              decoration: const BoxDecoration(color: incidenciasDarkGrey),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'BANDEJA DE ENTRADA',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 15.h,
                      ),
                      DropdownButton<String>(
                        isExpanded: true,
                        value: _incidentsProviderWatcher?.selectedApprovePath,
                        icon: const Icon(
                          Icons.keyboard_arrow_down_outlined,
                          color: incidenciasIPN,
                        ),
                        items: _incidentsProviderWatcher?.selectedApproveList
                            .map<DropdownMenuItem<String>>((String path) {
                          return DropdownMenuItem(
                            value: path,
                            child: Text(_selectedIncident(path)),
                          );
                        }).toList(),
                        onChanged: (String? value) async {
                          setState(() {
                            _incidentsProviderWatcher?.selectedApprovePath =
                                value!;
                          });
                          await _incidentsProviderReader
                              .getIncidentsToApprove(value!);
                          setState(() {});
                        },
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.end,
                      //   children: [
                      //     IncidenciasButton(
                      //         width: 120.w,
                      //         text: 'Tipo de incidencia',
                      //         callback: () => print('Tipo de incidencia')),
                      //     SizedBox(
                      //       width: 15.w,
                      //     ),
                      //     IncidenciasButton(
                      //         width: 100.w,
                      //         text: 'Fecha',
                      //         callback: () => print('Fecha')),
                      //   ],
                      // ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Container(
                        width: double.infinity,
                        height: 300.h,
                        decoration: BoxDecoration(
                          border: Border.all(color: incidenciasIPN),
                        ),
                        child: SingleChildScrollView(
                            child: Column(
                          children: _incidentsProviderWatcher
                              ?.incidents.reversed
                              .map((e) => IncidentsHistoryItemWidget(
                                  name: _selectedIncident(
                                      _incidentsProviderWatcher
                                          .selectedApprovePath),
                                  date: e['fecha_solicitud']
                                      .toString()
                                      .substring(0, 10),
                                  status: e['estatus_solicitud'],
                                  solicitantName:
                                      '${e['solicitante']['nombre']} ${e['solicitante']['ap_paterno']} ${e['solicitante']['ap_materno']}',
                                  solicitantEmail: e['solicitante']['email'],
                                  isInbox: true,
                                  incidentObject: e))
                              .toList() as List<Widget>,
                        )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const IncidenciasBottomMenu(),
          ],
        ),
      ),
    );
  }

  String _selectedIncident(String? path) {
    switch (path) {
      case "aprobaciones_permisos_economicos/":
        return "Permiso económico";
      case "aprobaciones_retardos/":
        return "Retardo";
      case "aprobaciones_omisiones/":
        return "Omisión de marcaje";
      case "aprobaciones_cambios_horario/":
        return "Cambio de horario";
      case "aprobaciones_reposiciones_horas/":
        return "Reposición de horas";
      default:
        return "Permiso económico";
    }
  }
}
