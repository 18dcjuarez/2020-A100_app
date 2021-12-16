import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gestion/theme.dart';

class IncidenciasBottomScrolleable extends StatelessWidget {
  final double initialChildSize;
  final double minChildSize;
  final double maxChildSize;
  final Widget content;
  final bool expanded;
  const IncidenciasBottomScrolleable(
      {Key? key,
      this.initialChildSize = 0.4,
      this.minChildSize = 0.4,
      this.maxChildSize = 0.8,
      this.expanded = false,
      this.content = const SizedBox()})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: expanded ? maxChildSize : initialChildSize,
      minChildSize: minChildSize,
      maxChildSize: maxChildSize,
      builder: (context, scrollController) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.w)),
          color: Colors.white,
        ),
        padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 4.5.w),
        child: ListView(
          controller: scrollController,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.8,
              child: Column(
                children: [
                  Center(
                    child: Container(
                      width: 30.w,
                      height: 5.h,
                      margin: EdgeInsets.symmetric(vertical: 15.w),
                      decoration: BoxDecoration(
                          color: incidenciasESCOM,
                          borderRadius: BorderRadius.circular(10.w)),
                    ),
                  ),
                  Expanded(child: content)
                ],
              ),
            )
            /* Center(
              child: Container(
                width: 30.w,
                height: 5.h,
                margin: EdgeInsets.symmetric(vertical: 15.w),
                decoration: BoxDecoration(
                    color: blue, borderRadius: BorderRadius.circular(10.w)),
              ),
            ),
            content */
          ],
        ),
      ),
    );
  }
}
