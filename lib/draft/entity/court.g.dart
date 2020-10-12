// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'court.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CourtModelAdapter extends TypeAdapter<CourtModel> {
  @override
  final int typeId = 0;

  @override
  CourtModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CourtModel(
      id: fields[0] as int,
      name: fields[1] as String,
      maxDailyBookings: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, CourtModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.maxDailyBookings);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CourtModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
