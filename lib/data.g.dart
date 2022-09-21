// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GeneralDataAdapter extends TypeAdapter<GeneralData> {
  @override
  final int typeId = 0;

  @override
  GeneralData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GeneralData()
      ..firstOpen = fields[0] as bool
      ..notifications = fields[1] as bool
      ..darkMode = fields[2] as bool
      ..dayHoursGoal = fields[3] as int
      ..nightHoursGoal = fields[4] as int;
  }

  @override
  void write(BinaryWriter writer, GeneralData obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.firstOpen)
      ..writeByte(1)
      ..write(obj.notifications)
      ..writeByte(2)
      ..write(obj.darkMode)
      ..writeByte(3)
      ..write(obj.dayHoursGoal)
      ..writeByte(4)
      ..write(obj.nightHoursGoal);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GeneralDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class LogDataAdapter extends TypeAdapter<LogData> {
  @override
  final int typeId = 1;

  @override
  LogData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LogData()
      ..logDate = fields[0] as DateTime
      ..totalTime = fields[1] as int
      ..notes = fields[2] as String
      ..isDay = fields[3] as bool
      ..weather = fields[4] as String;
  }

  @override
  void write(BinaryWriter writer, LogData obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.logDate)
      ..writeByte(1)
      ..write(obj.totalTime)
      ..writeByte(2)
      ..write(obj.notes)
      ..writeByte(3)
      ..write(obj.isDay)
      ..writeByte(4)
      ..write(obj.weather);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LogDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TemplateDataAdapter extends TypeAdapter<TemplateData> {
  @override
  final int typeId = 2;

  @override
  TemplateData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TemplateData()
      ..title = fields[0] as String
      ..totalTime = fields[1] as int
      ..notes = fields[2] as String
      ..isDay = fields[3] as bool
      ..weather = fields[4] as String;
  }

  @override
  void write(BinaryWriter writer, TemplateData obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.totalTime)
      ..writeByte(2)
      ..write(obj.notes)
      ..writeByte(3)
      ..write(obj.isDay)
      ..writeByte(4)
      ..write(obj.weather);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TemplateDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
