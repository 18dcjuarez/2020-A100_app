import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gestion/src/pages/inbox/inbox_page.dart';
import 'package:gestion/src/pages/incidents_history/incidents_history_page.dart';
import 'package:gestion/src/widgets/incidencias_bottom_menu.dart';
import 'package:gestion/src/widgets/incidencias_widgets.dart';
import 'package:gestion/theme.dart';

class HomePage extends StatelessWidget {
  static const String id = "/home";
  const HomePage({Key? key}) : super(key: key);

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
                  children: [
                    Icon(
                      Icons.account_circle_outlined,
                      color: Colors.white,
                      size: 40.h,
                    ),
                    SizedBox(width: 20.w),
                    Text(
                      'Bienvenido, David Cruz Juárez',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 15.h,
                      ),
                      Text(
                        'lunes 18 de octubre del 2021',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline1?.copyWith(
                            color: incidenciasIPN,
                            fontSize: 20.h,
                            fontWeight: FontWeight.w900),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      IncidenciasButton(
                          text: "2 incidencias en curso",
                          width: double.infinity,
                          callback: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const IncidentesHistoryPage()))),
                      SizedBox(
                        height: 350.h,
                      ),
                      // IncidenciasButton(
                      //     text: 'ESTADÍSTICAS',
                      //     callback: () => print('ESTADISTICAS'))
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
