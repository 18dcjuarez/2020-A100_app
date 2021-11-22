import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gestion/src/widgets/incidencias_bottom_menu.dart';
import 'package:gestion/theme.dart';

class ProfilePage extends StatelessWidget {
  static const String id = "/profile";
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                _profileField(context, label: 'Nombre', fieldValue: 'David'),
                _profileField(context,
                    label: 'Apellido Paterno:', fieldValue: 'Cruz'),
                _profileField(context,
                    label: 'Apellido Materno', fieldValue: 'Juárez'),
                _profileField(context,
                    label: 'Número de empleado', fieldValue: '1234123123'),
              ],
            ),
          )),
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
