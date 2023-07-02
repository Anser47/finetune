import 'package:fine_tune/model/model.dart';
import 'package:hive_flutter/adapters.dart';
part 'playlistmode.g.dart';

@HiveType(typeId: 2)
class PlayListModelclass extends HiveObject {
  @HiveField(0)
  String? playlistName;
  @HiveField(1)
  List<AudioModel>? playlistall = [];
  PlayListModelclass({required this.playlistName, this.playlistall});
}
