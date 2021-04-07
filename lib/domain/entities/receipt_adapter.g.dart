// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt_adapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReceiptAdapter extends TypeAdapter<Receipt> {
  @override
  final int typeId = 0;

  @override
  Receipt read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Receipt(
      fields[0] as String,
      fields[1] as DateTime,
      fields[2] as double,
      fields[3] as String,
      fields[4] as ReceiptCategory,
    );
  }

  @override
  void write(BinaryWriter writer, Receipt obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.storeName)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.total)
      ..writeByte(3)
      ..write(obj.tag)
      ..writeByte(4)
      ..write(obj.category);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReceiptAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
