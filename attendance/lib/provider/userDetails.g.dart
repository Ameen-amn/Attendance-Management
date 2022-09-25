// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userDetails.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserDetailsAdapter extends TypeAdapter<UserDetails> {
  @override
  final int typeId = 1;

  @override
  UserDetails read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserDetails(
      name: fields[1] as String,
      totalSubject: fields[2] as int,
      numOfPeriods: fields[3] as int,
      attendancePercentage: fields[4] as int,
      workingDays: (fields[5] as List).cast<String>(),
      timeTableAdded: fields[7] as bool,
      subjects: (fields[6] as List).cast<SubjectDetails>(),
      id: fields[0] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, UserDetails obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.totalSubject)
      ..writeByte(3)
      ..write(obj.numOfPeriods)
      ..writeByte(4)
      ..write(obj.attendancePercentage)
      ..writeByte(5)
      ..write(obj.workingDays)
      ..writeByte(6)
      ..write(obj.subjects)
      ..writeByte(7)
      ..write(obj.timeTableAdded);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserDetailsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
