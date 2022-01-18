import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gestion/src/pages/home/home_page.dart';
import 'package:gestion/src/providers/home_provider.dart';
import 'package:gestion/src/providers/incidents_provider.dart';
import 'package:gestion/src/widgets/incidencias_bottom_menu.dart';
import 'package:gestion/src/widgets/incidencias_widgets.dart';
import 'package:gestion/theme.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatelessWidget {
  final String name;
  final Map<String, dynamic>? incidentObject;
  const DetailPage({Key? key, this.name = "", this.incidentObject})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('DETAIL $incidentObject');
    final IncidentsProvider _incidentsProviderReader =
        context.read<IncidentsProvider>();
    final HomeProvider _homeProvider = context.watch<HomeProvider>();
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
                    name,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              child: name == "Permiso económico"
                  ? _economic(context, _incidentsProviderReader, _homeProvider)
                  : name == "Retardo"
                      ? _delay(context, _incidentsProviderReader, _homeProvider)
                      : name == "Omisión de marcaje"
                          ? _omission(
                              context, _incidentsProviderReader, _homeProvider)
                          : name == "Cambio de horario"
                              ? _change(context, _incidentsProviderReader,
                                  _homeProvider)
                              : Container()),
          const IncidenciasBottomMenu()
        ],
      )),
    );
  }

  Widget _economic(BuildContext context, IncidentsProvider providerReader,
      HomeProvider homeProvider) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      child: Column(
        children: [
          _showField(context,
              label: 'Nombre solicitante:',
              fieldValue:
                  '${incidentObject?['solicitante']['nombre']} ${incidentObject?['solicitante']['ap_paterno']} ${incidentObject?['solicitante']['ap_materno']}'),
          _showField(context,
              label: "Email:",
              fieldValue: '${incidentObject?['solicitante']['email']}'),
          _showField(context,
              label: "Fecha solicitud:",
              fieldValue:
                  '${incidentObject?['fecha_solicitud'].toString().substring(0, 10)}'),
          _showField(context,
              label: "Fecha inicio:",
              fieldValue: '${incidentObject?['fecha_inicio']}'),
          _showField(context,
              label: "Fecha fin: ",
              fieldValue: '${incidentObject?['fecha_fin']}'),
          _showField(context,
              label: "Dias", fieldValue: '${incidentObject?['cantidad_dias']}'),
          _actionButtons(context,
              path: "permiso_economico",
              id: '${incidentObject?['id']}',
              providerReader: providerReader,
              homeProvider: homeProvider)
        ],
      ),
    );
  }

  Widget _delay(BuildContext context, IncidentsProvider providerReader,
      HomeProvider homeProvider) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      child: Column(
        children: [
          _showField(context,
              label: 'Nombre solicitante:',
              fieldValue:
                  '${incidentObject?['solicitante']['nombre']} ${incidentObject?['solicitante']['ap_paterno']} ${incidentObject?['solicitante']['ap_materno']}'),
          _showField(context,
              label: "Email:",
              fieldValue: '${incidentObject?['solicitante']['email']}'),
          _showField(context,
              label: "Fecha solicitud:",
              fieldValue:
                  '${incidentObject?['fecha_solicitud'].toString().substring(0, 10)}'),
          _showField(context,
              label: "Dia Retardo:",
              fieldValue: '${incidentObject?['fecha_hora']}'),
          _showField(context,
              label: "Tipo: ", fieldValue: '${incidentObject?['tipo']}'),
          _actionButtons(context,
              path: "retardo",
              id: '${incidentObject?['id']}',
              providerReader: providerReader,
              homeProvider: homeProvider)
        ],
      ),
    );
  }

  Widget _omission(BuildContext context, IncidentsProvider providerReader,
      HomeProvider homeProvider) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      child: Column(
        children: [
          _showField(context,
              label: 'Nombre solicitante:',
              fieldValue:
                  '${incidentObject?['solicitante']['nombre']} ${incidentObject?['solicitante']['ap_paterno']} ${incidentObject?['solicitante']['ap_materno']}'),
          _showField(context,
              label: "Email:",
              fieldValue: '${incidentObject?['solicitante']['email']}'),
          _showField(context,
              label: "Fecha solicitud:",
              fieldValue:
                  '${incidentObject?['fecha_solicitud'].toString().substring(0, 10)}'),
          // GENERAL
          _showField(context,
              label: "Dia Retardo:",
              fieldValue: '${incidentObject?['fecha_hora']}'),
          _showField(context,
              label: "Tipo: ", fieldValue: '${incidentObject?['tipo']}'),
          _actionButtons(context,
              path: "omision",
              id: '${incidentObject?['id']}',
              providerReader: providerReader,
              homeProvider: homeProvider)
        ],
      ),
    );
  }

  Widget _change(BuildContext context, IncidentsProvider providerReader,
      HomeProvider homeProvider) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      child: Column(
        children: [
          _showField(context,
              label: 'Nombre solicitante:',
              fieldValue:
                  '${incidentObject?['solicitante']['nombre']} ${incidentObject?['solicitante']['ap_paterno']} ${incidentObject?['solicitante']['ap_materno']}'),
          _showField(context,
              label: "Email:",
              fieldValue: '${incidentObject?['solicitante']['email']}'),
          _showField(context,
              label: "Fecha solicitud:",
              fieldValue:
                  '${incidentObject?['fecha_solicitud'].toString().substring(0, 10)}'),
          // GENERAL
          _showField(context,
              label: "Entrada Anterior:",
              fieldValue: '${incidentObject?['fecha_hora_entrada_anterior']}'),
          _showField(context,
              label: "Entrada nueva: ",
              fieldValue: '${incidentObject?['fecha_hora_entrada_nueva']}'),
          _showField(context,
              label: "Salida Anterior:",
              fieldValue: '${incidentObject?['fecha_hora_salida_anterior']}'),
          _showField(context,
              label: "Salida nueva: ",
              fieldValue: '${incidentObject?['fecha_hora_salida_nueva']}'),
          _actionButtons(context,
              path: "cambio_horario",
              id: '${incidentObject?['id']}',
              providerReader: providerReader,
              homeProvider: homeProvider)
        ],
      ),
    );
  }

  Widget _showField(BuildContext context,
      {required String label, required String fieldValue}) {
    return Row(
      children: [
        Text(
          label,
          style: Theme.of(context)
              .textTheme
              .bodyText1
              ?.copyWith(color: incidenciasESCOM),
        ),
        SizedBox(
          width: 15.w,
        ),
        Expanded(
          child: Text(
            fieldValue,
            textAlign: TextAlign.right,
            style: Theme.of(context)
                .textTheme
                .headline1
                ?.copyWith(color: incidenciasIPN, fontWeight: FontWeight.w900),
          ),
        ),
      ],
    );
  }

  Widget _actionButtons(BuildContext context,
      {required String path,
      required String id,
      required IncidentsProvider providerReader,
      required HomeProvider homeProvider}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IncidenciasButton(
            callback: () async {
              final resp =
                  await providerReader.incidentAction("$path/return/$id");
              if (resp?.statusCode == 200 || resp?.statusCode == 201) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (builder) => const HomePage()),
                    (route) => false);
                homeProvider.currentSlide = 0;
                IncidenciasFlushbar.showBar(
                    context, 'Exito', 'Se rechazo la solicitud',
                    color: Colors.green);
              } else {
                IncidenciasFlushbar.showBar(
                    context, 'Error', 'Por favor intentalo más tarde');
              }
            },
            backgroundColor: incidenciasDarkGrey,
            text: 'RECHAZAR',
            width: 120.w,
          ),
          IncidenciasButton(
            callback: () async {
              final resp =
                  await providerReader.incidentAction("$path/approve/$id");
              if (resp?.statusCode == 200 || resp?.statusCode == 201) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (builder) => const HomePage()),
                    (route) => false);
                homeProvider.currentSlide = 0;
                IncidenciasFlushbar.showBar(
                    context, 'Exito', 'Se aprobo la solicitud',
                    color: Colors.green);
              } else {
                IncidenciasFlushbar.showBar(
                    context, 'Error', 'Por favor intentalo más tarde');
              }
            },
            text: 'ACEPTAR',
            width: 120.w,
          ),
        ],
      ),
    );
  }
}
