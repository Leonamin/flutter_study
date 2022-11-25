import 'package:flutter/material.dart';

class RoundTopContainer extends StatelessWidget {
  EdgeInsetsGeometry? margin;
  EdgeInsetsGeometry? padding;
  double? radius;
  Color? color;
  Widget? child;

  RoundTopContainer({
    super.key,
    this.margin,
    this.padding,
    this.color,
    this.radius,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        // borderRadius: BorderRadius.circular(5.0),
        child: Container(
          padding: padding,
          margin: margin,
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.vertical(top: Radius.circular(radius ?? 30)),
            color: color,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, 1.0), //(x,y)
                blurRadius: 5.0,
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}
