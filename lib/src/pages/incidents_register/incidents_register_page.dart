import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gestion/src/pages/home/home_page.dart';
import 'package:gestion/src/pages/incidents_register/widgets/incidents_register_calendar.dart';
import 'package:gestion/src/pages/incidents_register/widgets/incidents_register_name_field.dart';
import 'package:gestion/src/pages/incidents_register/widgets/incidents_register_one_day_calendar.dart';
import 'package:gestion/src/providers/home_provider.dart';
import 'package:gestion/src/providers/incidents_provider.dart';
import 'package:gestion/src/providers/user_provider.dart';
import 'package:gestion/src/widgets/incidencias_bottom_menu.dart';
import 'package:gestion/src/widgets/incidencias_widgets.dart';
import 'package:gestion/theme.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class IncidentsRegisterPage extends StatefulWidget {
  static const String id = "/incidents-register";
  const IncidentsRegisterPage({Key? key}) : super(key: key);

  @override
  State<IncidentsRegisterPage> createState() => _IncidentsRegisterPageState();
}

class _IncidentsRegisterPageState extends State<IncidentsRegisterPage> {
  @override
  Widget build(BuildContext context) {
    final UserProvider userProviderWatcher = context.watch<UserProvider>();
    final TextEditingController _firstNameController =
        TextEditingController(text: userProviderWatcher.user?.nombre);
    final TextEditingController _lastFNameController =
        TextEditingController(text: userProviderWatcher.user?.apPaterno);
    final TextEditingController _lastMNameController =
        TextEditingController(text: userProviderWatcher.user?.apMaterno);
    final TextEditingController _employeeNumber =
        TextEditingController(text: userProviderWatcher.user?.idIpn);
    final TextEditingController _asistCardController = TextEditingController(
        text: userProviderWatcher.user?.tarjetaAsistencia);
    final TextEditingController _comments = TextEditingController();
    final TextEditingController _startDateController = TextEditingController();
    final TextEditingController _endDateController = TextEditingController();
    final TextEditingController _fullDateController = TextEditingController();
    final TextEditingController _diaRetardoController = TextEditingController();
    final TextEditingController _horaRetardoController =
        TextEditingController();
    final TextEditingController _retardoFull = TextEditingController();
    final IncidentsProvider _incidentsProviderWatcher =
        context.watch<IncidentsProvider>();
    final IncidentsProvider _incidentsProviderReader =
        context.read<IncidentsProvider>();
    final HomeProvider _homeProvider = context.read<HomeProvider>();

    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                    'REGISTRAR INCIDENCIA',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              child: Column(
            children: [
              Row(
                children: [
                  IncidentsRegisterNameField(
                    textController: _firstNameController,
                    label: 'Nombre',
                  ),
                  IncidentsRegisterNameField(
                    textController: _lastFNameController,
                    label: 'Apellido Paterno',
                  ),
                ],
              ),
              Row(
                children: [
                  IncidentsRegisterNameField(
                    textController: _lastMNameController,
                    label: 'Apellido Materno',
                  ),
                  IncidentsRegisterNameField(
                    textController: _employeeNumber,
                    label: 'Número de empleado',
                    flexInt: 5,
                  ),
                ],
              ),
              Row(
                children: [
                  IncidentsRegisterNameField(
                    textController: _asistCardController,
                    label: 'Tarjeta de asistencia',
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.h),
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: _incidentsProviderWatcher.selectedIncidentType,
                  icon: const Icon(
                    Icons.keyboard_arrow_down_outlined,
                    color: incidenciasIPN,
                  ),
                  items: _incidentsProviderWatcher.incidentsType
                      .map<DropdownMenuItem<String>>((String incidentType) {
                    return DropdownMenuItem(
                      value: incidentType,
                      child: Text(incidentType),
                    );
                  }).toList(),
                  onChanged: (String? value) async {
                    setState(() {
                      _incidentsProviderReader.selectedIncidentType = value!;
                    });
                  },
                ),
              ),
              // CAMPOS PERMISO ECONÓMICO <<<<<<<<<<<<<<<<<<<<<<
              if (_incidentsProviderReader.selectedIncidentType ==
                  'Permiso económico')
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: TextFormField(
                      readOnly: true,
                      controller: _fullDateController,
                      decoration: InputDecoration(
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: incidenciasESCOM,
                            width: 1.0,
                            style: BorderStyle.solid,
                          ),
                        ),
                        labelText: 'Selecciona una fecha',
                        labelStyle: Theme.of(context)
                            .textTheme
                            .bodyText2
                            ?.copyWith(
                                color: incidenciasLightGrey,
                                fontWeight: FontWeight.normal),
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodyText2
                            ?.copyWith(
                                color: incidenciasLightGrey,
                                fontWeight: FontWeight.normal),
                      ),
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.copyWith(color: incidenciasIPN),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => IncidentsRegisterCalendar(
                                  start: _startDateController,
                                  end: _endDateController,
                                  fulldate: _fullDateController,
                                )),
                      ),
                    )),
              // CAMPOS RETARDO <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
              if (_incidentsProviderReader.selectedIncidentType == 'Retardo')
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.h),
                  child: Column(
                    children: [
                      TextFormField(
                        readOnly: true,
                        controller: _retardoFull,
                        decoration: InputDecoration(
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: incidenciasESCOM,
                              width: 1.0,
                              style: BorderStyle.solid,
                            ),
                          ),
                          labelText: 'Selecciona el día y hora',
                          labelStyle: Theme.of(context)
                              .textTheme
                              .bodyText2
                              ?.copyWith(
                                  color: incidenciasLightGrey,
                                  fontWeight: FontWeight.normal),
                          hintStyle: Theme.of(context)
                              .textTheme
                              .bodyText2
                              ?.copyWith(
                                  color: incidenciasLightGrey,
                                  fontWeight: FontWeight.normal),
                        ),
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(color: incidenciasIPN),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  IncidentsRegisterOneDayCalendar(
                                    diaRetardo: _diaRetardoController,
                                    horaRetardo: _horaRetardoController,
                                    retardoFull: _retardoFull,
                                    // start: _startDateController,
                                    // end: _endDateController,
                                    // fulldate: _fullDateController,
                                  )),
                        ),
                      ),
                      DropdownButton<String>(
                        isExpanded: true,
                        value: _incidentsProviderWatcher.tipoRetardo,
                        icon: const Icon(
                          Icons.keyboard_arrow_down_outlined,
                          color: incidenciasIPN,
                        ),
                        items: _incidentsProviderWatcher.tipoRetardoList
                            .map<DropdownMenuItem<String>>(
                                (String tipoRetardo) {
                          return DropdownMenuItem(
                            value: tipoRetardo,
                            child: Text(tipoRetardo),
                          );
                        }).toList(),
                        onChanged: (String? value) async {
                          setState(() {
                            _incidentsProviderWatcher.tipoRetardo = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              // IncidentsRegisterNameField(
              //   textController: _comments,
              //   label: 'Comentarios',
              //   inputMaxLines: 5,
              //   inputReadOnly: false,
              // ),
              SizedBox(
                height: 15.h,
              ),
              IncidenciasButton(
                callback: () async {
                  Response? resp;
                  // PERMISO ECONÓMICO
                  if (_incidentsProviderReader.selectedIncidentType ==
                      'Permiso económico') {
                    final Map<String, dynamic> body = {
                      'fecha_inicio':
                          _startDateController.text.substring(0, 10),
                      'fecha_fin': _endDateController.text.substring(0, 10),
                      'solicitante': userProviderWatcher.user?.email ?? '',
                    };
                    resp =
                        await _incidentsProviderReader.registerIncident(body);
                  }
                  // RETARDO
                  if (_incidentsProviderReader.selectedIncidentType ==
                      'Retardo') {
                    final Map<String, dynamic> body = {
                      'fecha_hora': _diaRetardoController.text,
                      'tipo': _incidentsProviderWatcher.tipoRetardo,
                      'solicitante': userProviderWatcher.user?.email ?? '',
                    };
                    print('BODY $body');
                    resp = await _incidentsProviderReader.registerRetardo(body);
                  }
                  print('RETARDO RESP${resp?.body}');
                  if (resp?.statusCode == 200 || resp?.statusCode == 201) {
                    context.read<IncidentsProvider>().getAllIncidentsTotal();
                    _homeProvider.currentSlide = 0;
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => const HomePage()),
                        (route) => false);
                    IncidenciasFlushbar.showBar(
                        context, 'Correcto', 'Tu solicitud ha sido enviada',
                        color: Colors.green);
                  } else {
                    IncidenciasFlushbar.showBar(
                        context, 'Error', 'Ocurrio un error inesperado');
                  }
                },
                text: 'Enviar',
              ),
              SizedBox(
                height: 50.h,
              ),
            ],
          )),
          const IncidenciasBottomMenu(),
        ],
      )),
    );
  }
}
