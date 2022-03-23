// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StudentAdapter extends TypeAdapter<Student> {
  @override
  final int typeId = 1;

  @override
  Student read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Student(
      fields[0] as int,
      fields[1] as String,
      fields[2] as EyeColor,
    );
  }

  @override
  void write(BinaryWriter writer, Student obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.eyeColor);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class EyeColorAdapter extends TypeAdapter<EyeColor> {
  @override
  final int typeId = 2;

  @override
  EyeColor read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return EyeColor.SIYAH;
      case 1:
        return EyeColor.MAVI;
      case 2:
        return EyeColor.YESIL;
      default:
        return EyeColor.SIYAH;
    }
  }

  @override
  void write(BinaryWriter writer, EyeColor obj) {
    switch (obj) {
      case EyeColor.SIYAH:
        writer.writeByte(0);
        break;
      case EyeColor.MAVI:
        writer.writeByte(1);
        break;
      case EyeColor.YESIL:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EyeColorAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
