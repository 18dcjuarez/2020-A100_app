import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gestion/src/data/enum/auth_state.dart';
import 'package:gestion/src/data/repositories/shared_preferences_repository.dart';
import 'package:gestion/src/pages/home/home_page.dart';
import 'package:gestion/src/pages/login/login_page.dart';
import 'package:gestion/src/providers/auth_provider.dart';
import 'package:gestion/src/providers/incidents_provider.dart';
import 'package:provider/provider.dart';

class RootPage extends StatefulWidget {
  static const String id = "/root";
  const RootPage({Key? key}) : super(key: key);

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  AuthState authState = AuthState.LOADING;
  String? token;

  @override
  void initState() {
    Future.microtask(() => getLoggedUser());
    Future.microtask(
        () => context.read<IncidentsProvider>().getAllIncidentsTotal());
    super.initState();
  }

  void getLoggedUser() async {
    final bool? resp = await context.read<AuthProvider>().verify();
    if (resp != null && resp) {
      authState = AuthState.SIGNED;
      setState(() {});
    } else {
      await SharedPreferencesRepository.instance.deleteKeys();
      authState = AuthState.NOTSIGNED;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (authState) {
      case AuthState.LOADING:
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      case AuthState.NOTSIGNED:
        return LoginPage();
      case AuthState.SIGNED:
        return const HomePage();
      default:
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
    }
  }
}
