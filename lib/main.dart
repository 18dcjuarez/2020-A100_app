// FLUTTER
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gestion/src/pages/inbox/inbox_page.dart';
import 'package:gestion/src/providers/auth_provider.dart';
import 'package:gestion/src/providers/incidents_provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// GENERAL
import 'package:gestion/theme.dart';

// PAGES
import 'package:gestion/src/pages/home/home_page.dart';
import 'package:gestion/src/pages/incidents_history/incidents_history_page.dart';
import 'package:gestion/src/pages/login/login_page.dart';
import 'package:gestion/src/pages/password_restore/forgot_password_page.dart';
import 'package:gestion/src/pages/root/root_page.dart';

// PROVIDERS
import 'package:gestion/src/providers/home_provider.dart';
import 'package:gestion/src/providers/user_provider.dart';

void main() async {
  await dotenv.load();
  initializeDateFormatting('es_MX');
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AuthProvider()),
      ChangeNotifierProvider(create: (_) => HomeProvider()),
      ChangeNotifierProvider(create: (_) => IncidentsProvider()),
      ChangeNotifierProvider(create: (_) => UserProvider())
    ],
    child: const MyApp(),
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
          HomePage.id: (_) => const HomePage(),
          InboxPage.id: (_) => const InboxPage(),
          IncidentesHistoryPage.id: (_) => const IncidentesHistoryPage(),
          LoginPage.id: (_) => LoginPage(),
          RootPage.id: (_) => RootPage(),
        },
      ),
    );
  }
}
