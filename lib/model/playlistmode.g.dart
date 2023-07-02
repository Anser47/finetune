// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlistmode.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlayListModelclassAdapter extends TypeAdapter<PlayListModelclass> {
  @override
  final int typeId = 2;

  @override
  PlayListModelclass read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlayListModelclass(
      playlistName: fields[0] as String?,
      playlistall: (fields[1] as List?)?.cast<AudioModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, PlayListModelclass obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.playlistName)
      ..writeByte(1)
      ..write(obj.playlistall);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayListModelclassAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
