// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subjectDetails.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubjectDetailsAdapter extends TypeAdapter<SubjectDetails> {
  @override
  final int typeId = 2;

  @override
  SubjectDetails read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SubjectDetails(
      id: fields[0] as int?,
      subjectName: fields[1] as String,
      totalClassesTaken: fields[2] as int,
      totalClassesAttended: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, SubjectDetails obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.subjectName)
      ..writeByte(2)
      ..write(obj.totalClassesTaken)
      ..writeByte(3)
      ..write(obj.totalClassesAttended);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubjectDetailsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
