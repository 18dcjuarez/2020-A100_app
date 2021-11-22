import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// PAGES
import 'package:gestion/src/pages/home/home_page.dart';
import 'package:gestion/src/pages/password_restore/forgot_password_page.dart';

// PROVIDERS
import 'package:gestion/src/providers/home_provider.dart';

// WIDGETS
import 'package:gestion/src/widgets/incidencias_widgets.dart';
import 'package:gestion/theme.dart';

class LoginPage extends StatelessWidget {
  static const String id = "/login";
  LoginPage({Key? key}) : super(key: key);

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final HomeProvider _homeProvider = context.read<HomeProvider>();
    return Scaffold(
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
                    IncidenciasInput.password(
                      label: 'Contraseña',
                      placeholder: null,
                      focusNode: _passwordFocusNode,
                      controller: _passwordController,
                      formatters: [FilteringTextInputFormatter.deny(' ')],
                      onChanged: (String value) => {print('VALUE $value')},
                    ),
                    const SizedBox(height: 30),
                    IncidenciasButton(
                      callback: () {
                        _homeProvider.currentSlide = 0;
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()),
                            (route) => false);
                      },
                      width: double.infinity,
                      text: 'INGRESAR',
                    ),
                    const SizedBox(height: 30),
                    GestureDetector(
                      child: Text(
                        "¿Olvidaste tu contraseña?",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(color: incidenciasIPN),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForgotPasswordPage()));
                      },
                    )
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
