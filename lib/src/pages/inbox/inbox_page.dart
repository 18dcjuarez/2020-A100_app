import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gestion/src/pages/incidents_history/widgets/incidentes_history_available_item_widget.dart';
import 'package:gestion/src/pages/incidents_history/widgets/incidents_history_item_widget.dart';
import 'package:gestion/src/widgets/incidencias_widgets.dart';
import 'package:gestion/theme.dart';

class InboxPage extends StatelessWidget {
  static const String id = "/inbox";
  const InboxPage({Key? key}) : super(key: key);

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
                              solicitantName: 'David Cruz Juárez',
                              isInbox: true,
                            ),
                            IncidentsHistoryItemWidget(
                              name: 'Retardo',
                              date: '22 de octubre del 2021',
                              status: 'Pendiente',
                              solicitantName: 'David Cruz Juárez',
                              isInbox: true,
                            ),
                            IncidentsHistoryItemWidget(
                              name: 'Retardo',
                              date: '22 de octubre del 2021',
                              status: 'Pendiente',
                              solicitantName: 'David Cruz Juárez',
                              isInbox: true,
                            ),
                            IncidentsHistoryItemWidget(
                              name: 'Retardo',
                              date: '22 de octubre del 2021',
                              status: 'Pendiente',
                              solicitantName: 'David Cruz Juárez',
                              isInbox: true,
                            ),
                            IncidentsHistoryItemWidget(
                              name: 'Retardo',
                              date: '22 de octubre del 2021',
                              status: 'Pendiente',
                              solicitantName: 'David Cruz Juárez',
                              isInbox: true,
                            ),
                            IncidentsHistoryItemWidget(
                              name: 'Retardo',
                              date: '22 de octubre del 2021',
                              status: 'Pendiente',
                              solicitantName: 'David Cruz Juárez',
                              isInbox: true,
                            ),
                          ],
                        )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 50.h,
              decoration: const BoxDecoration(color: incidenciasDarkGrey),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.home,
                      color: Colors.white,
                      size: 40.h,
                    ),
                    Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 40.h,
                    ),
                    Icon(
                      Icons.manage_accounts_rounded,
                      color: Colors.white,
                      size: 40.h,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
