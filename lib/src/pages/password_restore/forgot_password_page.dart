import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gestion/src/widgets/incidencias_widgets.dart';

class ForgotPasswordPage extends StatelessWidget {
  static const String id = "/forgot-password";
  ForgotPasswordPage({Key? key}) : super(key: key);

  final FocusNode _emailFocusNode = FocusNode();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const IncidenciasAppBar(
        leadingText: 'LOGIN',
      ),
      body: SingleChildScrollView(
        child: Container(
          height: ScreenUtil().screenHeight,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/logos/ipn_logo.png",
                width: ScreenUtil().screenWidth * 0.4,
              ),
              Image.asset(
                "assets/images/logos/escom_logo.png",
                width: ScreenUtil().screenWidth * 0.4,
              ),
              // SizedBox(
              //   height: 50.h,
              // ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Column(
                  children: [
                    IncidenciasInput.email(
                      label: 'Correo',
                      placeholder: 'hola@ipn.com',
                      focusNode: _emailFocusNode,
                      controller: _emailController,
                      formatters: [FilteringTextInputFormatter.deny(' ')],
                      onChanged: (String value) => {print('VALUE $value')},
                    ),
                    const SizedBox(height: 30),
                    IncidenciasButton(
                      callback: () => print('BUTTON'),
                      width: double.infinity,
                      text: 'SOLICITAR',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
