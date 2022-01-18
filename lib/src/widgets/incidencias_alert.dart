import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gestion/src/widgets/incidencias_bottom_scrollable.dart';
import 'package:gestion/src/widgets/incidencias_dialog.dart';

class Alerts {
  static succesFlushbar(BuildContext context, String title, String message,
      {FlushbarPosition? position}) {
    Flushbar(
      title: title,
      message: message,
      flushbarPosition: position ?? FlushbarPosition.BOTTOM,
      backgroundColor: Colors.green,
      duration: Duration(seconds: 3),
      flushbarStyle: FlushbarStyle.GROUNDED,
      icon: Icon(
        Icons.done,
        color: Colors.white,
      ),
    )..show(context);
  }

  static errorFlushbar(BuildContext context, String title, String message) {
    Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.GROUNDED,
      title: title,
      message: message,
      backgroundColor: Colors.red,
      icon: Icon(
        Icons.error,
        color: Colors.white,
      ),
      duration: Duration(seconds: 3),
    )..show(context);
  }

  static loading(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              backgroundColor: Colors.transparent,
              elevation: 0,
              content: Container(
                  alignment: FractionalOffset.center,
                  height: 80.0,
                  padding: const EdgeInsets.all(20.0),
                  child: CircularProgressIndicator()),
            ));
  }

  defaultDialog(BuildContext context, Widget widget) async {
    await showDialog(
        context: context, builder: (_) => IncidenciasDialog(widget: widget));
  }

  static showBottomScrolleable(
      {required BuildContext context, required Widget widget, bool? expanded}) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        isDismissible: true,
        builder: (context) => Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: IncidenciasBottomScrolleable(
                content: widget,
                expanded: expanded == null ? false : expanded,
              ),
            ));
  }
}
