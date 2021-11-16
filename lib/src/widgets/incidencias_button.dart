part of "incidencias_widgets.dart";

class IncidenciasButton extends StatelessWidget {
  final String text;
  final double width;
  final double height;
  final Color textColor;
  final void Function() callback;
  final Color backgroundColor;
  final double fontSize;
  final bool loading;

  const IncidenciasButton({
    required this.callback,
    this.width = 200,
    this.height = 60,
    this.fontSize = 12,
    this.text = 'Button',
    this.textColor = Colors.white,
    this.backgroundColor = incidenciasIPN,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: backgroundColor.withOpacity(callback != null ? 1 : 0.5),
          borderRadius: BorderRadius.all(Radius.circular(15.w)),
        ),
        child: Center(
          child: loading
              ? SizedBox(
                  height: (height) / 2,
                  width: (height) / 2,
                  child: const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : Text(
                  text,
                  textScaleFactor: 1.0,
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: (callback == null)
                          ? incidenciasLightestGrey
                          : textColor,
                      fontSize: fontSize),
                ),
        ),
      ),
    );
  }
}
