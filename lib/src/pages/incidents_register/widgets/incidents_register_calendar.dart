import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gestion/src/widgets/incidencias_widgets.dart';
import 'package:gestion/theme.dart';
import 'package:table_calendar/table_calendar.dart';

class IncidentsRegisterCalendar extends StatefulWidget {
  static const String id = "/calendar";

  final TextEditingController start;
  final TextEditingController end;
  final TextEditingController fulldate;

  IncidentsRegisterCalendar(
      {Key? key,
      required this.start,
      required this.end,
      required this.fulldate})
      : super(key: key);

  @override
  _IncidentsRegisterCalendarState createState() =>
      _IncidentsRegisterCalendarState();
}

class _IncidentsRegisterCalendarState extends State<IncidentsRegisterCalendar> {
  DateTime _focusedDay = DateTime.now().toLocal();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  bool correct = false;

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
                      'PERIODO INCIDENCIA',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  SizedBox(height: 30.h),
                  Expanded(
                    child: TableCalendar(
                      locale: 'es_ES',
                      shouldFillViewport: true,
                      firstDay: DateTime.utc(2010, 10, 16),
                      lastDay: DateTime.utc(2070, 3, 14),
                      focusedDay: _focusedDay,
                      selectedDayPredicate: (day) =>
                          isSameDay(_selectedDay, day),
                      rangeStartDay: _rangeStart,
                      rangeEndDay: _rangeEnd,
                      calendarFormat: CalendarFormat.month,
                      rangeSelectionMode: RangeSelectionMode.toggledOn,
                      headerStyle: const HeaderStyle(
                          formatButtonVisible: false,
                          titleCentered: false,
                          titleTextStyle: TextStyle(color: Colors.black)),
                      calendarStyle: const CalendarStyle(
                          defaultTextStyle: TextStyle(color: Colors.black),
                          todayDecoration: BoxDecoration(
                              color: Colors.grey, shape: BoxShape.circle),
                          selectedDecoration: BoxDecoration(
                              color: Colors.black, shape: BoxShape.circle),
                          rangeEndDecoration: BoxDecoration(
                              color: Colors.black, shape: BoxShape.circle),
                          rangeStartDecoration: BoxDecoration(
                              color: Colors.black, shape: BoxShape.circle),
                          rangeHighlightColor: incidenciasLightGrey,
                          withinRangeTextStyle: TextStyle(color: Colors.black)),
                      onRangeSelected: (start, end, focusedDay) {
                        setState(() {
                          _selectedDay = null;
                          _focusedDay = focusedDay;
                          _rangeStart = start;
                          _rangeEnd = end;
                          _validate3Days();
                          widget.start.text = _rangeStart.toString();
                          widget.end.text = _rangeEnd.toString();
                          if (widget.end.text != "null") {
                            widget.fulldate.text =
                                '${widget.start.text.substring(0, 10)} a ${widget.end.text.substring(0, 10)}';
                          }
                        });
                      },
                      onPageChanged: (focusedDay) {
                        _focusedDay = focusedDay;
                      },
                    ),
                  ),
                  IncidenciasButton(
                    text: "Escoger Fecha",
                    backgroundColor:
                        correct ? incidenciasIPN : incidenciasDarkGrey,
                    callback: () => correct ? Navigator.pop(context) : null,
                    /*  function: () => Alerts.showBottomScrolleable(
                        context: context, widget: CalendarTimeSelector()), */
                  ),
                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
      });
    }
  }

  void _validate3Days() {
    if (_rangeStart != null && _rangeEnd != null) {
      final diferenceDays =
          (_rangeEnd!.toLocal().difference(_rangeStart!.toLocal()).inHours / 24)
                  .round() +
              1;
      if (diferenceDays >= 4) {
        setState(() {
          correct = false;
          _rangeStart = null;
          _rangeEnd = null;
        });
        IncidenciasFlushbar.showBar(context, 'ERROR',
            'No se pueden pedir m??s de 3 d??as econ??micos seguidos');
      } else {
        setState(() {
          correct = true;
        });
      }
    }
  }
}
