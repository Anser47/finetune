import 'package:fine_tune/model/model.dart';
import 'package:fine_tune/model/playlistmode.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

ValueNotifier<List<PlayListModelclass>> eachlist = ValueNotifier([]);
playlistCreate(String name, BuildContext context) {
  bool check = false;
  for (var element in eachlist.value) {
    if (element.playlistName == name) {
      check = true;
      break;
    }
  }

  if (check == false) {
    PlayListModelclass item = PlayListModelclass(playlistName: name);
    addToPlaylist(item);
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Playlist name already exist"),
      ),
    );
  }
}

addToPlaylist(PlayListModelclass newPlaylist) async {
  final playListDB = await Hive.openBox<PlayListModelclass>('PlayList');
  playListDB.add(newPlaylist);
  getPlaylist();
  eachlist.notifyListeners();
}

Future<void> getPlaylist() async {
  final playListDB = await Hive.openBox<PlayListModelclass>('PlayList');
  eachlist.value.clear();
  eachlist.value.addAll(playListDB.values);
  eachlist.notifyListeners();
}

playlistDelete(int index) async {
  String? playlistname = eachlist.value[index].playlistName;
  final playListDB = await Hive.openBox<PlayListModelclass>('PlayList');
  for (PlayListModelclass elements in playListDB.values) {
    if (elements.playlistName == playlistname) {
      var key = elements.key;
      playListDB.delete(key);
    }
  }
  eachlist.value.removeAt(index);
  eachlist.notifyListeners();
}

Future<void> playlistRename(int index, String newname) async {
  bool check = false;
  for (var element in eachlist.value) {
    if (element.playlistName == newname) {
      check = true;
      break;
    }
  }
  if (check == false) {
    String? playListname = eachlist.value[index].playlistName;
    final playListDB = await Hive.openBox<PlayListModelclass>('PlayList');
    for (PlayListModelclass element in playListDB.values) {
      if (element.playlistName == playListname) {
        var key = element.key;
        element.playlistName = newname;
        playListDB.put(key, element);
      }
    }
    eachlist.value[index].playlistName = newname;
    eachlist.notifyListeners();
  }
}

songAddTOPlaylist(AudioModel song, String name, BuildContext context) {
  int indx = 0;
  bool check = false;
  List<AudioModel> forThisPlayList = [];
  for (var element in eachlist.value) {
    if (element.playlistName == name) {
      forThisPlayList = element.playlistall ?? forThisPlayList;
      break;
    }
    indx++;
  }
  for (var element in forThisPlayList) {
    if (element.songId == song.songId) {
      check = true;
      break;
    }
  }
  if (check == false) {
    forThisPlayList.add(song);
    PlayListModelclass thisPlaylist =
        PlayListModelclass(playlistName: name, playlistall: forThisPlayList);
    playlistSongAddDB(thisPlaylist);
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("The song is already exist"),
      ),
    );
  }
}

playlistSongAddDB(PlayListModelclass playListItem) async {
  final playListDB = await Hive.openBox<PlayListModelclass>('PlayList');
  int index = 0;
  for (var element in playListDB.values) {
    if (element.playlistName == playListItem.playlistName) {
      break;
    }
    index++;
  }
  playListDB.putAt(index, playListItem);
  getPlaylist();
  eachlist.notifyListeners();
}

playlistRemoveSong(AudioModel song, PlayListModelclass playlist) async {
  final playListDB = await Hive.openBox<PlayListModelclass>('PlayList');
  List<AudioModel> songs = [];
  songs = playlist.playlistall ?? songs;
  int indx = 0;
  for (var element in songs) {
    if (element.songId == song.songId) {
      break;
    }
    indx++;
  }
  songs.removeAt(indx);
  PlayListModelclass thisPlayList = PlayListModelclass(
      playlistName: playlist.playlistName, playlistall: songs);
  playlistSongAddDB(thisPlayList);
}
