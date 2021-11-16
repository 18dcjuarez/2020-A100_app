import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gestion/src/data/enum/auth_state.dart';
import 'package:gestion/src/pages/login/login_page.dart';

class RootPage extends StatefulWidget {
  static const String id = "/root";
  RootPage({Key? key}) : super(key: key);

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  AuthState authState = AuthState.LOADING;

  @override
  void initState() {
    Timer(
        const Duration(seconds: 3),
        () => setState(() {
              authState = AuthState.NOTSIGNED;
            }));
    super.initState();
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
        return Container();
      default:
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
    }
  }
}
