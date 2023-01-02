import 'package:clock_app_tutorial/models/alarm_info.dart';
import 'package:sqflite/sqflite.dart';

const String tableAlarm = 'alarm';
const String columnId = 'id';
const String columnTitle = 'title';
const String columnDateTime = 'alarmDateTime';
const String columnPending = 'isPending';
const String columnColorIndex = 'gradientColorIndex';

class AlarmHelper {
  static Database? _database;
  static final AlarmHelper _instance = AlarmHelper._();

  factory AlarmHelper() => _instance;

  AlarmHelper._();

  Future<Database> get database async {
    _database ??= await initializeDatabase();

    return _database!;
  }

  Future<Database> initializeDatabase() async {
    final dir = await getDatabasesPath();
    final path = "${dir}alarm.db";

    final database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          create table $tableAlarm (
            $columnId integer primary key autuincrement,
            $columnTitle text not null,
            $columnDateTime text not null,
            $columnPending integer,
            $columnColorIndex integer,
            )
        ''');
      },
    );

    return database;
  }

  void insertAlarm(AlarmInfo alarmInfo) async {
    final db = await database;

    await db.insert(tableAlarm, alarmInfo.toJson());
  }

  Future<List<AlarmInfo>> getAlarms() async {
    List<AlarmInfo> alarms = [];

    var db = await database;
    var result = await db.query(tableAlarm);
    for (var element in result) {
      var alarmInfo = AlarmInfo.fromJson(element);
      alarms.add(alarmInfo);
    }

    return alarms;
  }
}
