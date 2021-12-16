import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gestion/src/widgets/incidencias_widgets.dart';
import 'package:gestion/theme.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class IncidentsTimeSelector extends StatefulWidget {
  final TextEditingController hour;
  IncidentsTimeSelector({Key? key, required this.hour}) : super(key: key);

  @override
  _IncidentsTimeSelectorState createState() => _IncidentsTimeSelectorState();
}

class _IncidentsTimeSelectorState extends State<IncidentsTimeSelector> {
  final FocusNode _startHourFocusNode = FocusNode();
  final FocusNode _endHourFocusNode = FocusNode();
  final TextEditingController _text = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Escoge un horario",
            style: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(color: Colors.black)),
        SizedBox(height: 30.h),
        Row(
          children: [
            Expanded(
                child: IncidenciasInput.text(
              focusNode: _startHourFocusNode,
              controller: widget.hour,
              placeholder: "12:00",
              formatters: [MaskTextInputFormatter(mask: '##:##')],
            )),
            // Container(
            //   width: 30.w,
            //   height: 5.h,
            //   margin: EdgeInsets.symmetric(horizontal: 5.w),
            //   decoration: BoxDecoration(
            //       color: incidenciasESCOM,
            //       borderRadius: BorderRadius.circular(10.w)),
            // ),
            // Expanded(
            //     child: IncidenciasInput.text(
            //         focusNode: _endHourFocusNode,
            //         controller: _text,
            //         placeholder: "13:00",
            //         formatters: [MaskTextInputFormatter(mask: '##:##')]))
          ],
        ),
        SizedBox(height: 30.h),
        IncidenciasButton(
            text: "Listo", callback: () => Navigator.pop(context)),
        SizedBox(height: 10.h),
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Text("Omitir",
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: incidenciasLightGrey,
                  decoration: TextDecoration.underline)),
        )
      ],
    );
  }
}
