import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gestion/theme.dart';

class IncidentsRegisterNameField extends StatelessWidget {
  final TextEditingController textController;
  final String label;
  final int flexInt;
  final int inputMaxLines;
  final bool inputReadOnly;
  const IncidentsRegisterNameField(
      {Key? key,
      required this.textController,
      required this.label,
      this.flexInt = 3,
      this.inputMaxLines = 1,
      this.inputReadOnly = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: flexInt,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: TextFormField(
            readOnly: inputReadOnly,
            maxLines: inputMaxLines,
            decoration: InputDecoration(
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: incidenciasESCOM,
                  width: 1.0,
                  style: BorderStyle.solid,
                ),
              ),
              labelText: label,
              labelStyle: Theme.of(context).textTheme.bodyText2?.copyWith(
                  color: incidenciasLightGrey, fontWeight: FontWeight.normal),
              hintStyle: Theme.of(context).textTheme.bodyText2?.copyWith(
                  color: incidenciasLightGrey, fontWeight: FontWeight.normal),
            ),
            controller: textController,
            style: Theme.of(context)
                .textTheme
                .bodyText1
                ?.copyWith(color: incidenciasIPN),
          ),
        ));
  }
}
