part of "incidencias_widgets.dart";

class IncidenciasFlushbar {
  static showBar(BuildContext context, String title, String desc,
      {bool success = false, color = Colors.red}) {
    Flushbar(
      borderRadius: BorderRadius.circular(8),
      duration: const Duration(seconds: 3),
      backgroundColor: success ? Colors.green : color,
      titleText: Text(
        title,
        textScaleFactor: 1.0,
        style: Theme.of(context)
            .textTheme
            .bodyText1
            ?.copyWith(color: Colors.white),
      ),
      messageText: Text(
        desc,
        textScaleFactor: 1.0,
        style: Theme.of(context).textTheme.bodyText1?.copyWith(
              fontSize: 15.h,
              color: Colors.white,
            ),
      ),
      margin: EdgeInsets.only(left: 16.0.w, right: 16.0.w, bottom: 8.0.h),
    ).show(context);
  }
}
