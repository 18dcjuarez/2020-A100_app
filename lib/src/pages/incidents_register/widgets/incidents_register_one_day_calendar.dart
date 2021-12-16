import 'package:flutter/material.dart';
import 'package:gestion/src/pages/incidents_register/widgets/incidents_time_selector.dart';
import 'package:gestion/src/widgets/incidencias_alert.dart';
import 'package:gestion/src/widgets/incidencias_widgets.dart';
import 'package:gestion/theme.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IncidentsRegisterOneDayCalendar extends StatefulWidget {
  final TextEditingController diaRetardo;
  final TextEditingController horaRetardo;
  final TextEditingController retardoFull;
  const IncidentsRegisterOneDayCalendar(
      {Key? key,
      required this.diaRetardo,
      required this.horaRetardo,
      required this.retardoFull})
      : super(key: key);

  @override
  _IncidentsRegisterOneDayCalendarState createState() =>
      _IncidentsRegisterOneDayCalendarState();
}

class _IncidentsRegisterOneDayCalendarState
    extends State<IncidentsRegisterOneDayCalendar> {
  DateTime _focusedDay = DateTime.now().toLocal();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
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
                      'DÍA INCIDENCIA',
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
                      onDaySelected: (selectedDay, focusedDay) =>
                          _onDaySelected(selectedDay, focusedDay),
                      /* onRangeSelected: (start, end, focusedDay) {
                        setState(() {
                          _selectedDay = null;
                          _focusedDay = focusedDay;
                          _rangeStart = start;
                          _rangeEnd = end;
                        });
                      }, */
                      onPageChanged: (focusedDay) {
                        _focusedDay = focusedDay;
                      },
                    ),
                  ),
                ],
              ),
            ),
            IncidenciasButton(
              text: "continuar",
              backgroundColor: incidenciasIPN,
              // callback: () => Navigator.pop(context),
              callback: () =>
                  widget.horaRetardo.text == "" ? selectTime() : finish(),
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }

  void selectTime() {
    Alerts.showBottomScrolleable(
        context: context,
        widget: IncidentsTimeSelector(
          hour: widget.horaRetardo,
        ));
    setState(() {});
  }

  void finish() {
    setState(() {
      widget.retardoFull.text =
          '${widget.diaRetardo.text.substring(0, 10)} --- ${widget.horaRetardo.text}';
      widget.diaRetardo.text =
          widget.diaRetardo.text.replaceRange(11, 16, widget.horaRetardo.text);
    });
    Navigator.pop(context);
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        widget.diaRetardo.text = selectedDay.toString();
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
      });
    }
  }
}
