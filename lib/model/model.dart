import 'package:hive_flutter/adapters.dart';
import 'package:hive/hive.dart';
part 'model.g.dart';

@HiveType(typeId: 1)
class AudioModel {
  @HiveField(0)
  String? songname;
  @HiveField(1)
  String? artist;
  @HiveField(2)
  int? duration;
  @HiveField(3)
  String? songurl;
  @HiveField(4)
  int? id;
  @HiveField(5)
  int? songId;

  AudioModel(
      {required this.songname,
      required this.artist,
      required this.duration,
      required this.songurl,
      required this.songId,
      this.id});
}
