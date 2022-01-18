import 'package:flutter/material.dart';
import 'package:gestion/src/providers/auth_provider.dart';
import 'package:http/http.dart';
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
    final AuthProvider _authProviderWatcher = context.watch<AuthProvider>();
    final AuthProvider _authProviderReader = context.watch<AuthProvider>();
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
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
                      callback: () async {
                        _homeProvider.currentSlide = 0;
                        // // final Response resp = await _authProviderWatcher.login(
                        // //     '18dave2@gmail.com', '1z23hxR74');
                        // // final Response resp = await _authProviderWatcher.login(
                        // //     'jvelazquezg6@gmail.com', 'Password123%');
                        // final Response resp = await _authProviderWatcher.login(
                        //     'tanyabruce@gmail.com', 'Password123%');

                        final Response resp = await _authProviderWatcher.login(
                            _emailController.text, _passwordController.text);
                        if (resp.statusCode == 200 || resp.statusCode == 201) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()),
                              (route) => false);
                        } else if (resp.statusCode == 401) {
                          IncidenciasFlushbar.showBar(
                              context,
                              'Credenciales erroneas',
                              'Tu usuario o contraseña estan mal');
                          return;
                        } else {
                          IncidenciasFlushbar.showBar(context, 'Error',
                              'Ocurrio un error iniesperado al iniciar sesión');
                          return;
                        }
                      },
                      width: double.infinity,
                      text: 'INGRESAR',
                      loading: _authProviderReader.loading,
                    ),
                    const SizedBox(height: 30),
                    // GestureDetector(
                    //   child: Text(
                    //     "¿Olvidaste tu contraseña?",
                    //     style: Theme.of(context)
                    //         .textTheme
                    //         .bodyText1
                    //         ?.copyWith(color: incidenciasIPN),
                    //   ),
                    //   onTap: () {
                    //     Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) => ForgotPasswordPage()));
                    //   },
                    // )
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
