import 'package:fine_tune/model/model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

ValueNotifier<List<AudioModel>> recentlyNotifier = ValueNotifier([]);

addrecently(AudioModel recentsong) async {
  final recentDb = await Hive.openBox<AudioModel>('recent');
  bool check = false;
  int indx = 0;

  for (var element in recentDb.values) {
    if (element.songId == recentsong.songId) {
      recentDb.deleteAt(indx);
      recentDb.add(recentsong);
      check = true;
      break;
    }
    indx++;
  }

  if (check == false) {
    recentDb.add(recentsong);
  }
  getrecentSongs();
  recentlyNotifier.notifyListeners();
}

getrecentSongs() async {
  final recentDb = await Hive.openBox<AudioModel>('recent');
  recentlyNotifier.value.clear();
  List<AudioModel> temprecent = [];
  temprecent.addAll(recentDb.values);
  recentlyNotifier.value = temprecent.reversed.toList();
  // recentlyNotifier.value.addAll(recentDb.values);
  recentlyNotifier.notifyListeners();
}
