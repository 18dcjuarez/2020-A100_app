import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gestion/src/pages/inbox/widgets/detail_page.dart';
import 'package:gestion/theme.dart';

class IncidentsHistoryItemWidget extends StatelessWidget {
  final String name;
  final String date;
  final String status;
  final String solicitantName;
  final bool isInbox;
  final String solicitantEmail;
  final Map<String, dynamic>? incidentObject;

  const IncidentsHistoryItemWidget(
      {Key? key,
      this.name = 'Nombre incidencia',
      this.date = '22 de octubre del 2021',
      this.status = 'Pendiente',
      this.solicitantName = 'Desconocido',
      this.isInbox = false,
      this.solicitantEmail = 'user@email.com',
      this.incidentObject})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isInbox
        ? GestureDetector(
            child: _cardDisplay(context),
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (builder) => DetailPage(
                          name: name,
                          incidentObject: incidentObject,
                        ))),
          )
        : _cardDisplay(context);
  }

  Widget _cardDisplay(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: Theme.of(context).textTheme.headline6?.copyWith(
                    color: incidenciasIPN, fontWeight: FontWeight.w900),
              ),
              Text(
                status,
                style: Theme.of(context).textTheme.headline6?.copyWith(
                    color: incidenciasIPN, fontWeight: FontWeight.w400),
              )
            ],
          ),
          if (isInbox)
            Text(
              solicitantName,
              style: Theme.of(context).textTheme.headline6?.copyWith(
                  color: incidenciasIPN, fontWeight: FontWeight.w400),
            ),
          if (isInbox)
            Text(
              solicitantEmail,
              style: Theme.of(context).textTheme.headline6?.copyWith(
                  color: incidenciasIPN, fontWeight: FontWeight.w400),
            ),
          Text(
            date,
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
