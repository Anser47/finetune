// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:fine_tune/model/model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

ValueNotifier<List<AudioModel>> addfav = ValueNotifier([]);
List<AudioModel> favoriteList = [];
Future<void> addtofav(AudioModel value) async {
  final dB = await Hive.openBox<AudioModel>('All');
  bool check = false;
  for (var element in favoriteList) {
    if (element.songId == value.songId) {
      check = true;
      break;
    }
  }
  if (check == false) {
    int _id = await dB.add(value);
    value.id = _id;
    // addfav.notifyListeners();
  }
}

Future<void> getAll() async {
  final dB = await Hive.openBox<AudioModel>('All');
  favoriteList.clear();
  favoriteList.addAll(dB.values);
  // addfav.value.clear();
  // addfav.value.addAll(dB.values);
  // addfav.notifyListeners();
}

Future<void> deletefav(AudioModel value) async {
  final dB = await Hive.openBox<AudioModel>('All');
  int idx = 0;
  for (var element in dB.values) {
    if (element.songId == value.songId) {
      break;
    }
    idx++;
  }
  await dB.deleteAt(idx);
  getAll();
  addfav.notifyListeners();
}

bool isFavsong(AudioModel song) {
  for (var element in favoriteList) {
    if (element.songId == song.songId) {
      return true;
    }
  }
  // addfav.notifyListeners();
  return false;
}
