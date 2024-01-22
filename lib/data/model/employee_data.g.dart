// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EmployeeDataAdapter extends TypeAdapter<EmployeeData> {
  @override
  final int typeId = 1;

  @override
  EmployeeData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EmployeeData(
      id: fields[1] as String?,
      name: fields[2] as String?,
      role: fields[3] as String?,
      fromDate: fields[4] as String?,
      toDate: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, EmployeeData obj) {
    writer
      ..writeByte(5)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.role)
      ..writeByte(4)
      ..write(obj.fromDate)
      ..writeByte(5)
      ..write(obj.toDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmployeeDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
