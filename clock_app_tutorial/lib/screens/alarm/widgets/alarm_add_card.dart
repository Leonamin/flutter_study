import 'package:clock_app_tutorial/config/constants/theme_data.dart';
import 'package:clock_app_tutorial/screens/alarm/widgets/alarm_add_bottom_sheet.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AlarmAddCard extends StatelessWidget {
  const AlarmAddCard({super.key, this.radius, this.onPressed});

  final double? radius;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      strokeWidth: 3,
      color: CustomColors.clockOutline,
      borderType: BorderType.RRect,
      radius: Radius.circular(radius ?? 24),
      dashPattern: const [5, 10, 0],
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: CustomColors.clockBG,
            borderRadius: BorderRadius.all(Radius.circular(radius ?? 24))),
        height: 100,
        child: TextButton(
          onPressed: () {
            showModalBottomSheet(
              useRootNavigator: true,
              context: context,
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(radius ?? 24),
                ),
              ),
              builder: (context) {
                // modalwidget
                return AlarmAddBottomSheet(
                  onPressed: onPressed,
                );
              },
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/add_alarm.png',
                scale: 1.5,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Add Alarm',
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
