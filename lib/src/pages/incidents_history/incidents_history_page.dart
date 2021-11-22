import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gestion/src/pages/incidents_history/widgets/incidentes_history_available_item_widget.dart';
import 'package:gestion/src/pages/incidents_history/widgets/incidents_history_item_widget.dart';
import 'package:gestion/src/widgets/incidencias_bottom_menu.dart';
import 'package:gestion/src/widgets/incidencias_widgets.dart';
import 'package:gestion/theme.dart';

class IncidentesHistoryPage extends StatelessWidget {
  static const String id = "/incidents-history";
  const IncidentesHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                      'INCIDENCIAS',
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IncidenciasButton(
                              width: 120.w,
                              text: 'Tipo de incidencia',
                              callback: () => print('Tipo de incidencia')),
                          SizedBox(
                            width: 15.w,
                          ),
                          IncidenciasButton(
                              width: 100.w,
                              text: 'Fecha',
                              callback: () => print('Fecha')),
                        ],
                      ),
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
                          children: const [
                            IncidentsHistoryItemWidget(
                              name: 'Retardo',
                              date: '22 de octubre del 2021',
                              status: 'Pendiente',
                            ),
                            IncidentsHistoryItemWidget(
                              name: 'Día económico',
                              date: '22 de octubre del 2021',
                              status: 'Resuelto',
                            ),
                            IncidentsHistoryItemWidget(
                              name: 'Retardo',
                              date: '23 de octubre del 2021',
                              status: 'Rechazado',
                            ),
                            IncidentsHistoryItemWidget(
                              name: 'Falta',
                              date: '25 de octubre del 2021',
                              status: 'Aceptado',
                            ),
                            IncidentsHistoryItemWidget(
                              name: 'Retardo',
                              date: '25 de octubre del 2021',
                              status: 'Pending',
                            ),
                            IncidentsHistoryItemWidget(
                              name: 'Retardo',
                              date: '26 de octubre del 2021',
                              status: 'Pending',
                            ),
                            IncidentsHistoryItemWidget(
                              name: 'Retardo',
                              date: '27 de octubre del 2021',
                              status: 'Pending',
                            ),
                          ],
                        )),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Text(
                        'Disponibles',
                        style: Theme.of(context)
                            .textTheme
                            .headline1
                            ?.copyWith(color: incidenciasIPN),
                      ),
                      Column(
                        children: const [
                          IncidentsHistoryAvailableItemWidget(
                            name: 'Retardo',
                            availableItems: 3,
                          ),
                          IncidentsHistoryAvailableItemWidget(
                            name: 'Retardo',
                            availableItems: 3,
                          ),
                          IncidentsHistoryAvailableItemWidget(
                            name: 'Retardo',
                            availableItems: 3,
                          ),
                          IncidentsHistoryAvailableItemWidget(
                            name: 'Retardo',
                            availableItems: 3,
                          ),
                          IncidentsHistoryAvailableItemWidget(
                            name: 'Retardo',
                            availableItems: 3,
                          ),
                          IncidentsHistoryAvailableItemWidget(
                            name: 'Retardo',
                            availableItems: 3,
                          ),
                          IncidentsHistoryAvailableItemWidget(
                            name: 'Retardo',
                            availableItems: 3,
                          ),
                          IncidentsHistoryAvailableItemWidget(
                            name: 'Retardo',
                            availableItems: 3,
                          ),
                        ],
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
}
