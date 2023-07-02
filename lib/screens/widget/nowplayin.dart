import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:fine_tune/db/all_songs_funtion.dart';
import 'package:fine_tune/audio.dart';
import 'package:fine_tune/db/fav_function.dart';
import 'package:fine_tune/model/model.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:fine_tune/screens/playlist/playlistbottomsheet.dart';

import 'package:flutter/material.dart';

class NowPlayingScreen extends StatefulWidget {
  @override
  State<NowPlayingScreen> createState() => _NowPlayingScreenState();
}

class _NowPlayingScreenState extends State<NowPlayingScreen> {
  // late Box<AudioModel> allsongBox;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // allsongBox = Hive.box('all_song_db');
  }

  // bool  = false;
  bool _repeat = false;
  bool _shuffle = false;

  @override
  Widget build(BuildContext context) {
    return player.builderCurrent(builder: (context, isPlaying) {
      AudioModel currentSong =
          findSong(int.parse(isPlaying.audio.audio.metas.id!));
      bool _isFav = isFavsong(currentSong);
      return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF555449),
                Color(0xFFF0ECC2),
                Color.fromARGB(255, 68, 67, 58),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomLeft,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 95),
                    child: Text(
                      'Now Playing',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 90,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  width: double.infinity,
                  height: 300,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/Picture4.jpg'),
                    ),
                  ),
                ),
              ),
              Container(
                height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                  // color: Color.fromARGB(255, 155, 147, 147),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Text(
                          player.getCurrentAudioTitle,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            player.getCurrentAudioArtist,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: IconButton(
                              onPressed: () {
                                setState(
                                  () {
                                    if (!_isFav) {
                                      addtofav(currentSong);
                                      _isFav = !_isFav;
                                    } else {
                                      deletefav(currentSong);
                                      _isFav = !_isFav;
                                    }
                                  },
                                );
                              },
                              icon: Icon(_isFav
                                  ? Icons.favorite
                                  : Icons.favorite_border),
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: IconButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      PlaylistBottomSheet(music: currentSong),
                                ));
                              },
                              icon: const Icon(
                                Icons.playlist_add,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: PlayerBuilder.realtimePlayingInfos(
                            player: player,
                            builder: (context, realtimePlayingInfos) {
                              final duration =
                                  realtimePlayingInfos.current!.audio.duration;
                              final position =
                                  realtimePlayingInfos.currentPosition;
                              return ProgressBar(
                                progress: position,
                                thumbCanPaintOutsideBar: true,
                                total: duration,
                                timeLabelPadding: 15,
                                timeLabelTextStyle:
                                    TextStyle(color: Colors.white),
                                thumbColor: Color.fromARGB(225, 49, 49, 49),
                                baseBarColor:
                                    const Color.fromARGB(255, 85, 85, 85),
                                onSeek: (duration) => player.seek(duration),
                              );
                            }),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(
                                () {
                                  _shuffle = !_shuffle;
                                  if (_shuffle) {
                                    player.toggleShuffle();
                                  } else {
                                    player.setLoopMode(LoopMode.playlist);
                                  }
                                  print(_shuffle);
                                },
                              );
                            },
                            icon: Icon(
                              _shuffle
                                  ? Icons.shuffle_on_outlined
                                  : Icons.shuffle,
                              color: Colors.black,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(
                                () {
                                  player.previous();
                                },
                              );
                            },
                            icon: const Icon(
                              Icons.skip_previous,
                              color: Colors.black,
                            ),
                          ),
                          PlayerBuilder.isPlaying(
                            player: player,
                            builder: (context, isPlaying) {
                              return IconButton(
                                color: Colors.black,
                                iconSize: 45,
                                onPressed: () {
                                  player.playOrPause();
                                },
                                icon: Icon(isPlaying
                                    ? Icons.pause_circle_filled
                                    : Icons.play_circle_fill),
                              );
                            },
                          ),
                          IconButton(
                            onPressed: () {
                              setState(
                                () {
                                  player.next();
                                },
                              );
                            },
                            icon: const Icon(
                              Icons.skip_next,
                              color: Colors.black,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(
                                () {
                                  _repeat = !_repeat;
                                  if (_repeat) {
                                    player.setLoopMode(LoopMode.single);
                                  } else {
                                    player.setLoopMode(LoopMode.playlist);
                                  }
                                  print(_repeat);
                                },
                              );
                            },
                            icon: Icon(
                              _repeat ? Icons.repeat_one : Icons.repeat,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

AudioModel findSong(int songID) {
  AudioModel song = allsongNotifer.value[0];
  for (var element in allsongNotifer.value) {
    if (songID == element.songId) {
      return element;
    }
  }
  return song;
}
