import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:fine_tune/model/model.dart';

AssetsAudioPlayer player = AssetsAudioPlayer();
AudioModel? currentlyplaying;
List<Audio> playinglistAudio = [];
PlayingAudio(List<AudioModel> songs, int index) async {
  currentlyplaying = songs[index];
  player.stop();
  playinglistAudio.clear();
  for (int i = 0; i < songs.length; i++) {
    playinglistAudio.add(
      Audio.file(
        songs[i].songurl!,
        metas: Metas(
          title: songs[i].songname,
          artist: songs[i].artist,
          id: songs[i].songId.toString(),
        ),
      ),
    );
  }
  await player.open(
    Playlist(
      audios: playinglistAudio,
      startIndex: index,
    ),
    showNotification: true,
    notificationSettings: const NotificationSettings(stopEnabled: false),
  );
  player.setLoopMode(LoopMode.playlist);
}

// currentlyplaingfinder(int? playingId) {
//   for (AudioModel songs in allSongs) {
//     if (songs.id == playingId) {
//       currentlyplaying = songs;
//       break;
//     }
//   }
// }
