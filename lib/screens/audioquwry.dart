// ignore_for_file: depend_on_referenced_packages
import 'package:fine_tune/db/all_songs_funtion.dart';
import 'package:fine_tune/db/mostly_played_function.dart';
import 'package:fine_tune/model/model.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FetchSongs {
  final OnAudioQuery audioQuery = OnAudioQuery();
  requestPermission() async {
    PermissionStatus status = await Permission.storage.request();
    if (status.isGranted) {
      return true;
    } else {
      return false;
    }
  }

  songfatch() async {
    bool status = await requestPermission();
    if (status) {
      List<SongModel> fetchsongs = await audioQuery.querySongs(
          ignoreCase: true,
          orderType: OrderType.ASC_OR_SMALLER,
          sortType: null,
          uriType: UriType.EXTERNAL);
      for (SongModel element in fetchsongs) {
        if (element.fileExtension == "mp3") {
          final song = AudioModel(
              songname: element.displayNameWOExt,
              artist: element.artist,
              duration: element.duration,
              songurl: element.uri,
              songId: element.id);
          addToAllsongs(song);
        }
      }
    }

    await mostlyfetch();
  }
}
