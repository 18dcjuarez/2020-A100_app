import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gestion/src/pages/home/home_page.dart';
import 'package:gestion/src/pages/incidents_register/widgets/incidents_register_calendar.dart';
import 'package:gestion/src/pages/incidents_register/widgets/incidents_register_name_field.dart';
import 'package:gestion/src/pages/incidents_register/widgets/incidents_register_one_day_calendar.dart';
import 'package:gestion/src/pages/incidents_register/widgets/incidents_register_one_day_inout_calendar.dart';
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
    final TextEditingController _diaOmisionMarcajeController =
        TextEditingController();
    final TextEditingController _horaOmisionMarcajeController =
        TextEditingController();
    final TextEditingController _omisionMarcajeFull = TextEditingController();
    // INICIO CAMBIO HORARIO
    final TextEditingController _diaEntradaAnteriorCambioHorarioController =
        TextEditingController();
    final TextEditingController _horaEntradaAnteriorCambioHorarioController =
        TextEditingController();
    final TextEditingController _entradaAnteriorCambioHorarioFull =
        TextEditingController();
    final TextEditingController _diaSalidaAnteriorCambioHorarioController =
        TextEditingController();
    final TextEditingController _horaSalidaaAnteriorCambioHorarioController =
        TextEditingController();
    final TextEditingController _salidaAnteriorCambioHorarioFull =
        TextEditingController();
    final TextEditingController _diaEntradaNuevaCambioHorarioController =
        TextEditingController();
    final TextEditingController _horaEntradaNuevaCambioHorarioController =
        TextEditingController();
    final TextEditingController _entradaNuevaCambioHorarioFull =
        TextEditingController();
    final TextEditingController _diaSalidaNuevaCambioHorarioController =
        TextEditingController();
    final TextEditingController _horaSalidaNuevaCambioHorarioController =
        TextEditingController();
    final TextEditingController _salidaNuevaCambioHorarioFull =
        TextEditingController();
    // FIN CAMBIO HORARIO
    // INICIO REPOSICION DE HORAS
    // <<<<< ORIGINAL
    final TextEditingController _diaEntradaOriginalRHController =
        TextEditingController();
    final TextEditingController _horaEntradaOriginalRHController =
        TextEditingController();
    final TextEditingController _diaSalidaOriginalRHController =
        TextEditingController();
    final TextEditingController _horaSalidaOriginalRHController =
        TextEditingController();
    final TextEditingController _horarioOriginalFull = TextEditingController();
    // <<<<< DIA UNO
    final TextEditingController _diaUnoEntradaRHController =
        TextEditingController();
    final TextEditingController _horaUnoEntradaRHController =
        TextEditingController();
    final TextEditingController _diaUnoSalidaRHController =
        TextEditingController();
    final TextEditingController _horaUnoSalidaRHController =
        TextEditingController();
    final TextEditingController _horarioUnoFull = TextEditingController();
    // <<<<< DIA DOS
    final TextEditingController _diaDosEntradaRHController =
        TextEditingController();
    final TextEditingController _horaDosEntradaRHController =
        TextEditingController();
    final TextEditingController _diaDosSalidaRHController =
        TextEditingController();
    final TextEditingController _horaDosSalidaRHController =
        TextEditingController();
    final TextEditingController _horarioDosFull = TextEditingController();
    // <<<<< DIA TRES
    final TextEditingController _diaTresEntradaRHController =
        TextEditingController();
    final TextEditingController _horaTresEntradaRHController =
        TextEditingController();
    final TextEditingController _diaTresSalidaRHController =
        TextEditingController();
    final TextEditingController _horaTresSalidaRHController =
        TextEditingController();
    final TextEditingController _horarioTresFull = TextEditingController();
    // <<<<< DIA CUATRO
    final TextEditingController _diaCuatroEntradaRHController =
        TextEditingController();
    final TextEditingController _horaCuatroEntradaRHController =
        TextEditingController();
    final TextEditingController _diaCuatroSalidaRHController =
        TextEditingController();
    final TextEditingController _horaCuatroSalidaRHController =
        TextEditingController();
    final TextEditingController _horarioCuatroFull = TextEditingController();
    // DIA CINCO
    final TextEditingController _diaCincoEntradaRHController =
        TextEditingController();
    final TextEditingController _horaCincoEntradaRHController =
        TextEditingController();
    final TextEditingController _diaCincoSalidaRHController =
        TextEditingController();
    final TextEditingController _horaCincoSalidaRHController =
        TextEditingController();
    final TextEditingController _horarioCincoFull = TextEditingController();
    // DIA SEIS
    final TextEditingController _diaSeisEntradaRHController =
        TextEditingController();
    final TextEditingController _horaSeisEntradaRHController =
        TextEditingController();
    final TextEditingController _diaSeisSalidaRHController =
        TextEditingController();
    final TextEditingController _horaSeisSalidaRHController =
        TextEditingController();
    final TextEditingController _horarioSeisFull = TextEditingController();
    // DIA SIETE
    final TextEditingController _diaSieteEntradaRHController =
        TextEditingController();
    final TextEditingController _horaSieteEntradaRHController =
        TextEditingController();
    final TextEditingController _diaSieteSalidaRHController =
        TextEditingController();
    final TextEditingController _horaSieteSalidaRHController =
        TextEditingController();
    final TextEditingController _horarioSieteFull = TextEditingController();
    // DIA OCHO
    final TextEditingController _diaOchoEntradaRHController =
        TextEditingController();
    final TextEditingController _horaOchoEntradaRHController =
        TextEditingController();
    final TextEditingController _diaOchoSalidaRHController =
        TextEditingController();
    final TextEditingController _horaOchoSalidaRHController =
        TextEditingController();
    final TextEditingController _horarioOchoFull = TextEditingController();
    // FIN REPOSICION DE HORAS

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
              // INICIO CAMPOS PERMISO ECONÓMICO <<<<<<<<<<<<<<<<<<<<<<
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
              // FIN CAMPOS PERMISO ECONÓMICO <<<<<<<<<<<<<<<<<<<<<<
              // INICIO CAMPOS RETARDO <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
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
              // FIN CAMPOS RETARDO <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
              // INICIO CAMPOS OMISIÓN DE MARCAJE
              if (_incidentsProviderReader.selectedIncidentType ==
                  'Omisión de marcaje')
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.h),
                  child: Column(
                    children: [
                      TextFormField(
                        readOnly: true,
                        controller: _omisionMarcajeFull,
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
                                    diaRetardo: _diaOmisionMarcajeController,
                                    horaRetardo: _horaOmisionMarcajeController,
                                    retardoFull: _omisionMarcajeFull,
                                    // start: _startDateController,
                                    // end: _endDateController,
                                    // fulldate: _fullDateController,
                                  )),
                        ),
                      ),
                      DropdownButton<String>(
                        isExpanded: true,
                        value: _incidentsProviderWatcher.tipoOmisionMarcaje,
                        icon: const Icon(
                          Icons.keyboard_arrow_down_outlined,
                          color: incidenciasIPN,
                        ),
                        items: _incidentsProviderWatcher.tipoOmisionMarcajeList
                            .map<DropdownMenuItem<String>>(
                                (String tipoRetardo) {
                          return DropdownMenuItem(
                            value: tipoRetardo,
                            child: Text(tipoRetardo),
                          );
                        }).toList(),
                        onChanged: (String? value) async {
                          setState(() {
                            _incidentsProviderWatcher.tipoOmisionMarcaje =
                                value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              // FIN CAMPOS OMISION DE MARCAJE
              // INICIO CAMPOS CAMBIO DE HORARIO
              if (_incidentsProviderReader.selectedIncidentType ==
                  'Cambio de horario')
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.h),
                  child: Column(
                    children: [
                      TextFormField(
                        readOnly: true,
                        controller: _entradaAnteriorCambioHorarioFull,
                        decoration: InputDecoration(
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: incidenciasESCOM,
                              width: 1.0,
                              style: BorderStyle.solid,
                            ),
                          ),
                          labelText:
                              'Selecciona el día y hora de entrada anterior',
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
                                  IncidentsRegisterOneDayInOutCalendar(
                                    fullString:
                                        _entradaAnteriorCambioHorarioFull,
                                    entryDay:
                                        _diaEntradaAnteriorCambioHorarioController,
                                    entryTime:
                                        _horaEntradaAnteriorCambioHorarioController,
                                    exitDay:
                                        _diaSalidaAnteriorCambioHorarioController,
                                    exitTime:
                                        _horaSalidaaAnteriorCambioHorarioController,
                                  )),
                        ),
                      ),
                      TextFormField(
                        readOnly: true,
                        controller: _entradaNuevaCambioHorarioFull,
                        decoration: InputDecoration(
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: incidenciasESCOM,
                              width: 1.0,
                              style: BorderStyle.solid,
                            ),
                          ),
                          labelText:
                              'Selecciona el día y hora de entrada nueva',
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
                                  IncidentsRegisterOneDayInOutCalendar(
                                    fullString: _entradaNuevaCambioHorarioFull,
                                    entryDay:
                                        _diaEntradaNuevaCambioHorarioController,
                                    entryTime:
                                        _horaEntradaNuevaCambioHorarioController,
                                    exitDay:
                                        _diaSalidaNuevaCambioHorarioController,
                                    exitTime:
                                        _horaSalidaNuevaCambioHorarioController,
                                  )),
                        ),
                      ),
                    ],
                  ),
                ),
              // FIN CAMPOS CAMBIO DE HORARIO
              // INICIO CAMPOS REPOSICION DE HORAS
              if (_incidentsProviderReader.selectedIncidentType ==
                  'Reposición de horas')
                SizedBox(
                  height: 250.h,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.h),
                      child: Column(
                        children: [
                          TextFormField(
                            readOnly: true,
                            controller: _horarioOriginalFull,
                            decoration: InputDecoration(
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: incidenciasESCOM,
                                  width: 1.0,
                                  style: BorderStyle.solid,
                                ),
                              ),
                              labelText: 'Selecciona el día y horario',
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
                                      IncidentsRegisterOneDayInOutCalendar(
                                        fullString: _horarioOriginalFull,
                                        entryDay:
                                            _diaEntradaOriginalRHController,
                                        entryTime:
                                            _horaEntradaOriginalRHController,
                                        exitDay: _diaSalidaOriginalRHController,
                                        exitTime:
                                            _horaSalidaOriginalRHController,
                                      )),
                            ),
                          ),
                          // DIA UNO
                          TextFormField(
                            readOnly: true,
                            controller: _horarioUnoFull,
                            decoration: InputDecoration(
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: incidenciasESCOM,
                                  width: 1.0,
                                  style: BorderStyle.solid,
                                ),
                              ),
                              labelText:
                                  'Selecciona el día y horario de primera reposicion',
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
                                      IncidentsRegisterOneDayInOutCalendar(
                                        fullString: _horarioUnoFull,
                                        entryDay: _diaUnoEntradaRHController,
                                        entryTime: _horaUnoEntradaRHController,
                                        exitDay: _diaUnoSalidaRHController,
                                        exitTime: _horaUnoSalidaRHController,
                                      )),
                            ),
                          ),
                          // DIA DOS
                          TextFormField(
                            readOnly: true,
                            controller: _horarioDosFull,
                            decoration: InputDecoration(
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: incidenciasESCOM,
                                  width: 1.0,
                                  style: BorderStyle.solid,
                                ),
                              ),
                              labelText:
                                  'Selecciona el día y horario de segunda reposicion',
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
                                      IncidentsRegisterOneDayInOutCalendar(
                                        fullString: _horarioDosFull,
                                        entryDay: _diaDosEntradaRHController,
                                        entryTime: _horaDosEntradaRHController,
                                        exitDay: _diaDosSalidaRHController,
                                        exitTime: _horaDosSalidaRHController,
                                      )),
                            ),
                          ),
                          // DIA TRES
                          TextFormField(
                            readOnly: true,
                            controller: _horarioTresFull,
                            decoration: InputDecoration(
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: incidenciasESCOM,
                                  width: 1.0,
                                  style: BorderStyle.solid,
                                ),
                              ),
                              labelText:
                                  'Selecciona el día y horario de tercera reposicion',
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
                                      IncidentsRegisterOneDayInOutCalendar(
                                        fullString: _horarioTresFull,
                                        entryDay: _diaTresEntradaRHController,
                                        entryTime: _horaTresEntradaRHController,
                                        exitDay: _diaTresSalidaRHController,
                                        exitTime: _horaTresSalidaRHController,
                                      )),
                            ),
                          ),
                          // DIA CUATRO
                          TextFormField(
                            readOnly: true,
                            controller: _horarioCuatroFull,
                            decoration: InputDecoration(
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: incidenciasESCOM,
                                  width: 1.0,
                                  style: BorderStyle.solid,
                                ),
                              ),
                              labelText:
                                  'Selecciona el día y horario de cuarta reposicion',
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
                                      IncidentsRegisterOneDayInOutCalendar(
                                        fullString: _horarioCuatroFull,
                                        entryDay: _diaCuatroEntradaRHController,
                                        entryTime:
                                            _horaCuatroEntradaRHController,
                                        exitDay: _diaCuatroSalidaRHController,
                                        exitTime: _horaCuatroSalidaRHController,
                                      )),
                            ),
                          ),
                          // DIA CINCO
                          TextFormField(
                            readOnly: true,
                            controller: _horarioCincoFull,
                            decoration: InputDecoration(
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: incidenciasESCOM,
                                  width: 1.0,
                                  style: BorderStyle.solid,
                                ),
                              ),
                              labelText:
                                  'Selecciona el día y horario de quinta reposicion',
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
                                      IncidentsRegisterOneDayInOutCalendar(
                                        fullString: _horarioCincoFull,
                                        entryDay: _diaCincoEntradaRHController,
                                        entryTime:
                                            _horaCincoEntradaRHController,
                                        exitDay: _diaCincoSalidaRHController,
                                        exitTime: _horaCincoSalidaRHController,
                                      )),
                            ),
                          ),
                          // DIA SEIS
                          TextFormField(
                            readOnly: true,
                            controller: _horarioSeisFull,
                            decoration: InputDecoration(
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: incidenciasESCOM,
                                  width: 1.0,
                                  style: BorderStyle.solid,
                                ),
                              ),
                              labelText:
                                  'Selecciona el día y horario de sexta reposicion',
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
                                      IncidentsRegisterOneDayInOutCalendar(
                                        fullString: _horarioSeisFull,
                                        entryDay: _diaSeisEntradaRHController,
                                        entryTime: _horaSeisEntradaRHController,
                                        exitDay: _diaSeisSalidaRHController,
                                        exitTime: _horaSeisSalidaRHController,
                                      )),
                            ),
                          ),
                          // DIA SIETE
                          TextFormField(
                            readOnly: true,
                            controller: _horarioSieteFull,
                            decoration: InputDecoration(
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: incidenciasESCOM,
                                  width: 1.0,
                                  style: BorderStyle.solid,
                                ),
                              ),
                              labelText:
                                  'Selecciona el día y horario de septima reposicion',
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
                                      IncidentsRegisterOneDayInOutCalendar(
                                        fullString: _horarioSieteFull,
                                        entryDay: _diaSieteEntradaRHController,
                                        entryTime:
                                            _horaSieteEntradaRHController,
                                        exitDay: _diaSieteSalidaRHController,
                                        exitTime: _horaSieteSalidaRHController,
                                      )),
                            ),
                          ),
                          // DIA OCHO
                          TextFormField(
                            readOnly: true,
                            controller: _horarioOchoFull,
                            decoration: InputDecoration(
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: incidenciasESCOM,
                                  width: 1.0,
                                  style: BorderStyle.solid,
                                ),
                              ),
                              labelText:
                                  'Selecciona el día y horario de octava reposicion',
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
                                      IncidentsRegisterOneDayInOutCalendar(
                                        fullString: _horarioOchoFull,
                                        entryDay: _diaOchoEntradaRHController,
                                        entryTime: _horaOchoEntradaRHController,
                                        exitDay: _diaOchoSalidaRHController,
                                        exitTime: _horaOchoSalidaRHController,
                                      )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              // FIN CAMPOS REPOSICION DE HORAS
              SizedBox(
                height: 15.h,
              ),
              IncidenciasButton(
                callback: () async {
                  Response? resp;
                  // INICIO PERMISO ECONÓMICO
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
                  // FIN PERMISO ECONÓMICO
                  // INICIO RETARDO
                  if (_incidentsProviderReader.selectedIncidentType ==
                      'Retardo') {
                    final Map<String, dynamic> body = {
                      'fecha_hora': _diaRetardoController.text,
                      'tipo': _incidentsProviderWatcher.tipoRetardo,
                      'solicitante': userProviderWatcher.user?.email ?? '',
                    };
                    resp = await _incidentsProviderReader.registerRetardo(body);
                  }
                  // FIN RETARDO
                  // INICIO OMISIÓN MARCAJE
                  if (_incidentsProviderReader.selectedIncidentType ==
                      'Omisión de marcaje') {
                    final Map<String, dynamic> body = {
                      'fecha_hora': _diaOmisionMarcajeController.text,
                      'tipo': _incidentsProviderWatcher.tipoOmisionMarcaje,
                      'solicitante': userProviderWatcher.user?.email ?? '',
                    };
                    resp = await _incidentsProviderReader
                        .registerOmisionMarcaje(body);
                  }
                  // FIN OMISION MARCAJE
                  // INICIO CAMBIO DE HORARIO
                  if (_incidentsProviderReader.selectedIncidentType ==
                      'Cambio de horario') {
                    final Map<String, dynamic> body = {
                      'fecha_hora_entrada_anterior':
                          _diaEntradaAnteriorCambioHorarioController.text,
                      'fecha_hora_salida_anterior':
                          _diaSalidaAnteriorCambioHorarioController.text,
                      'fecha_hora_entrada_nueva':
                          _diaEntradaNuevaCambioHorarioController.text,
                      'fecha_hora_salida_nueva':
                          _diaSalidaNuevaCambioHorarioController.text,
                      'solicitante': userProviderWatcher.user?.email ?? '',
                    };
                    resp = await _incidentsProviderReader
                        .registerCambioHorario(body);
                  }
                  // FIN CAMBIO DE HORARIO
                  // INICIO REPOSICION DE HORAS
                  if (_incidentsProviderReader.selectedIncidentType ==
                      'Reposición de horas') {
                    List<Map<String, dynamic>> respList = [];
                    // <<<<<UNO
                    if (_diaUnoEntradaRHController.text != '') {
                      respList.add({
                        'fecha_hora_entrada': _diaUnoEntradaRHController.text,
                        'fecha_hora_salida': _diaUnoSalidaRHController.text
                      });
                    }
                    // <<<<<DOS
                    if (_diaDosEntradaRHController.text != '') {
                      respList.add({
                        'fecha_hora_entrada': _diaDosEntradaRHController.text,
                        'fecha_hora_salida': _diaDosSalidaRHController.text
                      });
                    }
                    // <<<<<TRES
                    if (_diaTresEntradaRHController.text != '') {
                      respList.add({
                        'fecha_hora_entrada': _diaTresEntradaRHController.text,
                        'fecha_hora_salida': _diaTresSalidaRHController.text
                      });
                    }
                    // <<<<<CUATRO
                    if (_diaCuatroEntradaRHController.text != '') {
                      respList.add({
                        'fecha_hora_entrada':
                            _diaCuatroEntradaRHController.text,
                        'fecha_hora_salida': _diaCuatroSalidaRHController.text
                      });
                    }
                    // <<<<<CINCO
                    if (_diaCincoEntradaRHController.text != '') {
                      respList.add({
                        'fecha_hora_entrada': _diaCincoEntradaRHController.text,
                        'fecha_hora_salida': _diaCincoSalidaRHController.text
                      });
                    }
                    // <<<<<SEIS
                    if (_diaSeisEntradaRHController.text != '') {
                      respList.add({
                        'fecha_hora_entrada': _diaSeisEntradaRHController.text,
                        'fecha_hora_salida': _diaSeisSalidaRHController.text
                      });
                    }
                    // <<<<<SIETE
                    if (_diaSieteEntradaRHController.text != '') {
                      respList.add({
                        'fecha_hora_entrada': _diaSieteEntradaRHController.text,
                        'fecha_hora_salida': _diaSieteSalidaRHController.text
                      });
                    }
                    // <<<<<OCHO
                    if (_diaOchoEntradaRHController.text != '') {
                      respList.add({
                        'fecha_hora_entrada': _diaOchoEntradaRHController.text,
                        'fecha_hora_salida': _diaOchoSalidaRHController.text
                      });
                    }
                    final Map<String, dynamic> body = {
                      'fecha_hora_entrada':
                          _diaEntradaOriginalRHController.text,
                      'fecha_hora_salida': _diaSalidaOriginalRHController.text,
                      'reposiciones': respList,
                      'solicitante': userProviderWatcher.user?.email ?? '',
                    };
                    final response = await _incidentsProviderReader
                        .registerReposicionHoras(body);
                    if (response?.statusCode == 200 ||
                        response?.statusCode == 201) {
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
                      return;
                    } else {
                      IncidenciasFlushbar.showBar(
                          context, 'Error', 'Ocurrio un error inesperado');
                      return;
                    }
                  }
                  //FIN REPOSICION DE HORAS
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
