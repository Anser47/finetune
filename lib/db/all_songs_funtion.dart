import 'package:fine_tune/model/model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

ValueNotifier<List<AudioModel>> allsongNotifer = ValueNotifier([]);
List<AudioModel> allsongbloc = [];
Future<void> addToAllsongs(AudioModel value) async {
  final allsongdB = await Hive.openBox<AudioModel>('all_song_db');
  bool check = false;
  for (var element in allsongdB.values) {
    if (element.songId == value.songId) {
      check = true;
      break;
    }
  }
  if (check == false) {
    await allsongdB.add(value);
    allsongNotifer.notifyListeners();
  }
}

Future<void> getAllSongs() async {
  final allsongdB = await Hive.openBox<AudioModel>('all_song_db');
  allsongbloc.clear();
  allsongbloc.addAll(allsongdB.values);
  // allsongNotifer.value.clear();
  // allsongNotifer.value.addAll(allsongbloc);
  // allsongNotifer.notifyListeners();
}
