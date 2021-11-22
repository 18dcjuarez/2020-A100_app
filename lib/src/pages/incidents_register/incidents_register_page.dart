import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gestion/src/pages/incidents_register/widgets/incidents_register_calendar.dart';
import 'package:gestion/src/pages/incidents_register/widgets/incidents_register_name_field.dart';
import 'package:gestion/src/providers/incidents_provider.dart';
import 'package:gestion/src/widgets/incidencias_bottom_menu.dart';
import 'package:gestion/src/widgets/incidencias_widgets.dart';
import 'package:gestion/theme.dart';
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
    final TextEditingController _firstNameController =
        TextEditingController(text: 'David');
    final TextEditingController _lastFNameController =
        TextEditingController(text: 'Cruz');
    final TextEditingController _lastMNameController =
        TextEditingController(text: 'Juárez');
    final TextEditingController _employeeNumber =
        TextEditingController(text: '1234123123');
    final TextEditingController _comments = TextEditingController();
    final IncidentsProvider _incidentsProviderWatcher =
        context.watch<IncidentsProvider>();
    final IncidentsProvider _incidentsProviderReader =
        context.read<IncidentsProvider>();

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
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: TextFormField(
                    readOnly: true,
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
                          builder: (context) => IncidentsRegisterCalendar()),
                    ),
                  )),
              IncidentsRegisterNameField(
                textController: _comments,
                label: 'Comentarios',
                inputMaxLines: 5,
                inputReadOnly: false,
              ),
              IncidenciasButton(
                callback: () => print('SEND'),
                text: 'Enviar',
              ),
              SizedBox(
                height: 50.h,
              )
            ],
          )),
          const IncidenciasBottomMenu(),
        ],
      )),
    );
  }
}
