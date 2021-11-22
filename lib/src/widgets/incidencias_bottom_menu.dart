import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gestion/src/pages/home/home_page.dart';
import 'package:gestion/src/pages/inbox/inbox_page.dart';
import 'package:gestion/src/pages/incidents_register/incidents_register_page.dart';
import 'package:gestion/src/pages/profile/profile.dart';
import 'package:gestion/src/pages/statistics/statistics_page.dart';
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
            // HOME - SLIDE(0)
            GestureDetector(
              onTap: () {
                _homeProviderReader.currentSlide = 0;
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                  (route) => false,
                );
              },
              child: Icon(
                Icons.home,
                color: _homeProviderWatcher.currentSlide == 0
                    ? incidenciasESCOM
                    : Colors.white,
                size: 40.h,
              ),
            ),
            // INBOX - SLIDE(1)
            GestureDetector(
              onTap: () {
                _homeProviderReader.currentSlide = 1;
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const InboxPage()),
                  (route) => false,
                );
              },
              child: Icon(
                Icons.email,
                color: _homeProviderWatcher.currentSlide == 1
                    ? incidenciasESCOM
                    : Colors.white,
                size: 40.h,
              ),
            ),
            // CREATE INCIDENCE - SLIDE(2)
            GestureDetector(
              onTap: () {
                _homeProviderReader.currentSlide = 2;
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const IncidentsRegisterPage()),
                  (route) => false,
                );
              },
              child: Icon(
                Icons.note_add,
                color: _homeProviderWatcher.currentSlide == 2
                    ? incidenciasESCOM
                    : Colors.white,
                size: 40.h,
              ),
            ),
            // STATISTICS - SLIDE(3)
            GestureDetector(
              onTap: () {
                _homeProviderReader.currentSlide = 3;
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const StatisticsPage()),
                    (route) => false);
              },
              child: Icon(
                Icons.bar_chart,
                color: _homeProviderWatcher.currentSlide == 3
                    ? incidenciasESCOM
                    : Colors.white,
                size: 40.h,
              ),
            ),
            // USER PROFILE - SLIDE(4)
            GestureDetector(
              onTap: () {
                _homeProviderReader.currentSlide = 4;
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfilePage()),
                    (route) => false);
              },
              child: Icon(
                Icons.manage_accounts_rounded,
                color: _homeProviderWatcher.currentSlide == 4
                    ? incidenciasESCOM
                    : Colors.white,
                size: 40.h,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
