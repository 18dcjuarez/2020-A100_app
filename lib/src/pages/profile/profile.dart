import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gestion/src/pages/login/login_page.dart';
import 'package:gestion/src/providers/auth_provider.dart';
import 'package:gestion/src/providers/user_provider.dart';
import 'package:gestion/src/widgets/incidencias_bottom_menu.dart';
import 'package:gestion/src/widgets/incidencias_widgets.dart';
import 'package:gestion/theme.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  static const String id = "/profile";
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthProvider authProviderWatcher = context.watch<AuthProvider>();
    final UserProvider userProviderReader = context.read<UserProvider>();

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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Perfil',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
            child: Column(
              children: [
                _profileField(context,
                    label: 'Nombre',
                    fieldValue: userProviderReader.user?.nombre ?? ''),
                _profileField(context,
                    label: 'Apellido Paterno:',
                    fieldValue: userProviderReader.user?.apPaterno ?? ''),
                _profileField(context,
                    label: 'Apellido Materno',
                    fieldValue: userProviderReader.user?.apMaterno ?? ''),
                _profileField(context,
                    label: 'Número de empleado',
                    fieldValue: userProviderReader.user?.idIpn ?? ''),
                _profileField(context,
                    label: 'Tarjeta de asistencia',
                    fieldValue:
                        userProviderReader.user?.tarjetaAsistencia ?? ''),
                _profileField(context,
                    label: 'Correo',
                    fieldValue: userProviderReader.user?.email ?? ''),
              ],
            ),
          )),
          IncidenciasButton(
            text: 'Logout',
            callback: () async {
              final bool? resp = await authProviderWatcher.logout();
              if (resp != null && resp) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                    (route) => false);
              }
            },
          ),
          SizedBox(height: 15.h),
          const IncidenciasBottomMenu()
        ],
      )),
    );
  }

  Widget _profileField(BuildContext context,
      {String label = 'field', String fieldValue = 'value'}) {
    return Row(
      children: [
        Text(
          label,
          style: Theme.of(context)
              .textTheme
              .bodyText1
              ?.copyWith(color: incidenciasLightGrey),
        ),
        SizedBox(
          width: 15.w,
        ),
        Text(
          fieldValue,
          style: Theme.of(context)
              .textTheme
              .headline1
              ?.copyWith(color: incidenciasIPN),
        ),
      ],
    );
  }
}
