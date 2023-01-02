import 'package:clock_app_tutorial/config/timezone.dart';
import 'package:clock_app_tutorial/helpers/alarm_helper.dart';
import 'package:clock_app_tutorial/main.dart';
import 'package:clock_app_tutorial/models/alarm_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;

class AlarmAddBottomSheet extends StatefulWidget {
  final Function()? onPressed;

  AlarmAddBottomSheet({super.key, this.onPressed});

  @override
  State<AlarmAddBottomSheet> createState() => _AlarmAddBottomSheetState();
}

class _AlarmAddBottomSheetState extends State<AlarmAddBottomSheet> {
  final AlarmHelper _alarmHelper = AlarmHelper();

  DateTime _alarmTime = DateTime.now();

  late String _alarmTimeString;

  bool _isRepeatSelected = false;

  @override
  void initState() {
    // TODO: implement initState
    _alarmTimeString = DateFormat('HH:mm').format(_alarmTime);
    _alarmHelper.initializeDatabase().then((value) {
      debugPrint('-------------database initialized--------------');
    });
    super.initState();
  }

  // 알람 설정 관련한 변수
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setModalState) {
        return Container(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              TextButton(
                onPressed: () async {
                  var selectedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (selectedTime != null) {
                    final now = DateTime.now();
                    var selectedDateTime = DateTime(now.year, now.month,
                        now.day, selectedTime.hour, selectedTime.minute);
                    _alarmTime = selectedDateTime;
                    setModalState(() {
                      _alarmTimeString =
                          DateFormat('HH:mm').format(selectedDateTime);
                    });
                  }
                },
                child: Text(
                  _alarmTimeString,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(color: Colors.black),
                ),
              ),
              ListTile(
                title: Text(
                  'Repeat',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: Colors.black,
                      ),
                ),
                trailing: Switch(
                  onChanged: (value) {
                    setModalState(() {
                      _isRepeatSelected = value;
                    });
                  },
                  value: _isRepeatSelected,
                ),
              ),
              ListTile(
                title: Text(
                  'Sound',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: Colors.black,
                      ),
                ),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              ListTile(
                title: Text(
                  'Title',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: Colors.black,
                      ),
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
              FloatingActionButton.extended(
                onPressed: () {
                  onSaveAlarm(_isRepeatSelected);
                  widget.onPressed!();
                },
                icon: const Icon(Icons.alarm),
                label: Text(
                  'Save',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: Colors.black,
                      ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void scheduleAlarm(
      DateTime scheduledNotificationDateTime, AlarmInfo alarmInfo,
      {required bool isRepeating}) async {
    // 플랫폼 설정
    const androidPlaformChannelSpecifics = AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      channelDescription: 'alarm!',
      // sound: ,
    );

    const iosPlatformChannelSpecifics = DarwinNotificationDetails(
      // sound: ,
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    var platformSpecifics = const NotificationDetails(
        android: androidPlaformChannelSpecifics,
        iOS: iosPlatformChannelSpecifics);

    final timeZone = TimeZone();
    // The device's timezone.
    String timeZoneName = await timeZone.getTimeZoneName();

    // Find the 'current location'
    final location = await timeZone.getLocation(timeZoneName);

    // 매일 반복
    if (isRepeating) {
      await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'Office',
        alarmInfo.title,
        tz.TZDateTime.from(scheduledNotificationDateTime, location),
        platformSpecifics,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
      );
    } else {
      await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'Office',
        alarmInfo.title,
        tz.TZDateTime.from(scheduledNotificationDateTime, tz.local),
        platformSpecifics,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dateAndTime,
      );
    }
  }

  void onSaveAlarm(bool _isRepeating) {
    DateTime? scheduleAlarmDateTime;
    if (_alarmTime.isAfter(DateTime.now())) {
      scheduleAlarmDateTime = _alarmTime;
    } else {
      scheduleAlarmDateTime = _alarmTime.add(const Duration(days: 1));
    }

    var alarmInfo = AlarmInfo(
      alarmDateTime: scheduleAlarmDateTime,
      gradientColorIndex: 1,
      title: 'alarm',
    );
    _alarmHelper.insertAlarm(alarmInfo);
    scheduleAlarm(scheduleAlarmDateTime, alarmInfo, isRepeating: _isRepeating);
    Navigator.pop(context);
  }
}
