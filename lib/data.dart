import 'package:hive/hive.dart';

part 'data.g.dart';

@HiveType(typeId: 0)
class GeneralData extends HiveObject {
  @HiveField(0)
  late bool firstOpen;

  @HiveField(1)
  late bool notifications;

  @HiveField(2)
  late bool darkMode;

  @HiveField(3)
  late int dayHoursGoal;

  @HiveField(4)
  late int nightHoursGoal;
}

@HiveType(typeId: 1)
class LogData extends HiveObject {
  @HiveField(0)
  late DateTime logDate;

  @HiveField(1)
  late int totalTime;

  @HiveField(2)
  late String notes;

  @HiveField(3)
  late bool isDay;

  @HiveField(4)
  late String weather;
}

@HiveType(typeId: 2)
class TemplateData extends HiveObject {
  @HiveField(0)
  late String title;

  @HiveField(1)
  late int totalTime;

  @HiveField(2)
  late String notes;

  @HiveField(3)
  late bool isDay;

  @HiveField(4)
  late String weather;
}