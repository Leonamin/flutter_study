import 'package:clock_app_tutorial/helpers/alarm_helper.dart';
import 'package:clock_app_tutorial/models/alarm_info.dart';
import 'package:clock_app_tutorial/screens/alarm/widgets/alarm_add_card.dart';
import 'package:clock_app_tutorial/screens/alarm/widgets/alarm_card.dart';
import 'package:flutter/material.dart';

class AlarmPage extends StatefulWidget {
  const AlarmPage({super.key});

  static const double cardRadius = 24;

  @override
  State<AlarmPage> createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  final AlarmHelper _alarmHelper = AlarmHelper();
  List<AlarmInfo>? _alarms;

  @override
  void initState() {
    // TODO: implement initState
    _alarmHelper.initializeDatabase().then((value) {
      debugPrint('-------------database initialized--------------');
      loadAlarms();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 64),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Alarm',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          Expanded(
            // AnimatedList를 어떻게 하면 쓸 수 있을까.
            child: ListView.builder(
              itemCount: _alarms != null ? _alarms!.length + 1 : 1,
              itemBuilder: (context, index) {
                if (_alarms == null || (_alarms?.length == index)) {
                  return AlarmAddCard(
                    onPressed: loadAlarms,
                  );
                }
                return AlarmCard(
                  alarmInfo: _alarms![index],
                  onDeletePressed: () {
                    deleteAlarm(_alarms![index].id);
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Future<void> loadAlarms() async {
    _alarms = await _alarmHelper.getAlarms();
  }

  void deleteAlarm(int? id) {
    _alarmHelper.delete(id);
    //unsubscribe for notification
    loadAlarms();
  }
}
