import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gestion/src/pages/inbox/inbox_page.dart';
import 'package:gestion/src/pages/incidents_register/incidents_register_page.dart';
import 'package:gestion/src/providers/home_provider.dart';
import 'package:gestion/theme.dart';
import 'package:provider/provider.dart';

class IncidenciasBottomMenu extends StatelessWidget {
  const IncidenciasBottomMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeProvider _homeProviderWatcher = context.watch<HomeProvider>();
    final HomeProvider _homeProviderReader = context.read<HomeProvider>();
    return Container(
      width: double.infinity,
      height: 50.h,
      decoration: const BoxDecoration(color: incidenciasDarkGrey),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                _homeProviderReader.currentSlide = 0;
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const InboxPage()));
              },
              child: Icon(
                Icons.home,
                color: _homeProviderWatcher.currentSlide == 0
                    ? incidenciasESCOM
                    : Colors.white,
                size: 40.h,
              ),
            ),
            GestureDetector(
              onTap: () {
                _homeProviderReader.currentSlide = 1;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const IncidentsRegisterPage()));
              },
              child: Icon(
                Icons.note_add,
                color: _homeProviderWatcher.currentSlide == 1
                    ? incidenciasESCOM
                    : Colors.white,
                size: 40.h,
              ),
            ),
            Icon(
              Icons.manage_accounts_rounded,
              color: _homeProviderWatcher.currentSlide == 2
                  ? incidenciasESCOM
                  : Colors.white,
              size: 40.h,
            ),
          ],
        ),
      ),
    );
  }
}
