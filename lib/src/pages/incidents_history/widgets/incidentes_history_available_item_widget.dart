import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gestion/theme.dart';

class IncidentsHistoryAvailableItemWidget extends StatelessWidget {
  final String name;
  final int availableItems;

  const IncidentsHistoryAvailableItemWidget(
      {Key? key, this.name = 'Nombre incidencia', this.availableItems = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(color: incidenciasIPN, fontWeight: FontWeight.w900),
          ),
          Text(
            availableItems.toString(),
            style: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(color: incidenciasIPN, fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }
}
