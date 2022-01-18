import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IncidenciasDialog extends StatefulWidget {
  final Widget widget;
  IncidenciasDialog({Key? key, required this.widget}) : super(key: key);

  @override
  _IncidenciasDialogState createState() => _IncidenciasDialogState();
}

class _IncidenciasDialogState extends State<IncidenciasDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.w))),
      elevation: 0,
      content: Container(height: 250.h, child: widget.widget),
    );
  }
}
