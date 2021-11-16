part of "incidencias_widgets.dart";

class IncidenciasAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String leadingText;
  final Color leadingColor;
  final double leadingWidth;
  final List<Widget> actions;
  final Color backgroundColor;

  const IncidenciasAppBar(
      {this.title = '',
      this.leadingText = 'Home',
      this.leadingColor = incidenciasLightestGrey,
      this.leadingWidth = 100,
      this.actions = const [],
      this.backgroundColor = incidenciasDarkGrey});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      actions: actions,
      leading: Padding(
        padding: EdgeInsets.only(left: 10.w),
        child: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Row(
            children: [
              Icon(
                Icons.arrow_back_ios_rounded,
                color: leadingColor,
                size: 20.w,
              ),
              SizedBox(width: 5.w),
              Text(
                leadingText,
                textScaleFactor: 1.0,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(color: leadingColor),
              ),
            ],
          ),
        ),
      ),
      leadingWidth: leadingWidth,
      backgroundColor: backgroundColor,
      iconTheme: const IconThemeData(color: Colors.black),
      title: title.isNotEmpty
          ? Text(
              title,
              textScaleFactor: 1.0,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(color: Colors.black),
            )
          : null,
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(30.h);
}
