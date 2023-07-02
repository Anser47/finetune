import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:fine_tune/db/mostly_played_function.dart';
import 'package:fine_tune/db/recently_function.dart';
import 'package:fine_tune/audio.dart';
import 'package:fine_tune/screens/favourites/favourites.dart';
import 'package:fine_tune/screens/playlist/playlist.dart';
import 'package:fine_tune/screens/search/search.dart';
import 'package:fine_tune/screens/homescreen.dart';
import 'package:flutter/material.dart';
import '../model/model.dart';
import 'Widget/nowplayin.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    ScreenSearch(),
    PlaylistScreen(),
    Screenfav()
  ];

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Colors.amber,
      ),
      child: Scaffold(
        body: _screens[_currentIndex],
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            player.builderCurrent(
              builder: (context, isPlaying) {
                AudioModel recentsong =
                    findSong(int.parse(isPlaying.audio.audio.metas.id!));
                addrecently(recentsong);

                addmostplayed(recentsong);

                String _currentSong = player.getCurrentAudioTitle;
                return GestureDetector(
                  onTap: () {
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //     builder: (context) => NowPlayingScreen(),
                    //   ),
                    // );
                  },
                  child: ListTile(
                    tileColor: Colors.black,
                    title: Text(
                      _currentSong,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: PlayerBuilder.isPlaying(
                      player: player,
                      builder: (context, isPlaying) => IconButton(
                        onPressed: () {
                          player.playOrPause();
                        },
                        icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                      ),
                    ),
                  ),
                );
              },
            ),
            BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (int index) {
                setState(
                  () {
                    _currentIndex = index;
                  },
                );
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'Search',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.library_music_outlined),
                  label: 'Playlist',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_border),
                  label: 'Favorite',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
