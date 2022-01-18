import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gestion/src/pages/inbox/inbox_page.dart';
import 'package:gestion/src/pages/incidents_history/incidents_history_page.dart';
import 'package:gestion/src/providers/incidents_provider.dart';
import 'package:gestion/src/providers/user_provider.dart';
import 'package:gestion/src/widgets/incidencias_bottom_menu.dart';
import 'package:gestion/src/widgets/incidencias_widgets.dart';
import 'package:gestion/theme.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const String id = "/home";
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int totalPendingIncidents = 0;

  @override
  void initState() {
    Future.microtask(() => context.read<UserProvider>().getUser());
    super.initState();
  }

  void getPending(int pending) {
    setState(() {
      totalPendingIncidents = pending;
    });
  }

  @override
  Widget build(BuildContext context) {
    final String now =
        DateFormat('EEEEE 10, MMMM, y', 'es_MX').format(DateTime.now());
    final List<String> nowSplit = now.split(',');
    final UserProvider? _userProviderWatcher = context.watch<UserProvider>();
    final IncidentsProvider? _incidentsProviderWatcher =
        context.watch<IncidentsProvider>();
    getPending(_incidentsProviderWatcher?.totalIncidents ?? 0);
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
                    Expanded(
                      child: Text(
                        'Bienvenido, ${_userProviderWatcher?.user?.nombre} ${_userProviderWatcher?.user?.apPaterno} ${_userProviderWatcher?.user?.apMaterno}',
                        maxLines: 2,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
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
                        '${nowSplit[0]} de ${nowSplit[1]} del ${nowSplit[2]} ',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline1?.copyWith(
                            color: incidenciasIPN,
                            fontSize: 20.h,
                            fontWeight: FontWeight.w900),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      if (_userProviderWatcher?.user?.rol == "Personal docente")
                        IncidenciasButton(
                            // text: "$totalPendingIncidents incidencias en curso",
                            text: "Ver mis incidencias en curso",
                            width: double.infinity,
                            callback: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const IncidentesHistoryPage()))),
                      SizedBox(
                        height: 350.h,
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
