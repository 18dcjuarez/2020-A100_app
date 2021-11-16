// FLUTTER
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gestion/src/pages/inbox/inbox_page.dart';
import 'package:provider/provider.dart';

// GENERAL
import 'package:gestion/theme.dart';

// PAGES
import 'package:gestion/src/pages/home/home_page.dart';
import 'package:gestion/src/pages/incidents_history/incidents_history_page.dart';
import 'package:gestion/src/pages/login/login_page.dart';
import 'package:gestion/src/pages/password_restore/forgot_password_page.dart';
import 'package:gestion/src/pages/root/root_page.dart';

// PROVIDERS
import 'package:gestion/src/providers/user_provider.dart';

void main() async {
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => UserProvider())],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: () => MaterialApp(
        title: 'Sistema de Gestion',
        debugShowCheckedModeBanner: true,
        theme: GestionTheme.theme,
        home: RootPage(),
        routes: <String, WidgetBuilder>{
          ForgotPasswordPage.id: (_) => ForgotPasswordPage(),
          HomePage.id: (_) => HomePage(),
          InboxPage.id: (_) => InboxPage(),
          IncidentesHistoryPage.id: (_) => IncidentesHistoryPage(),
          LoginPage.id: (_) => LoginPage(),
          RootPage.id: (_) => RootPage(),
        },
      ),
    );
  }
}
