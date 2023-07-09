import 'package:fine_tune/audio.dart';
import 'package:fine_tune/db/fav_function.dart';
import 'package:fine_tune/db/recently_function.dart';
import 'package:fine_tune/model/model.dart';
import 'package:fine_tune/screens/bottoman.dart';
import 'package:fine_tune/screens/playlist/playlistbottomsheet.dart';
import 'package:fine_tune/screens/widget/nowplayin.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class ScreenRecently extends StatefulWidget {
  const ScreenRecently({super.key});

  @override
  State<ScreenRecently> createState() => _ScreenRecentlyState();
}

class _ScreenRecentlyState extends State<ScreenRecently> {
  late Box<AudioModel> recentBox;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    recentBox = Hive.box<AudioModel>("recent");
    setState(
      () {
        getAll();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    getAll();
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop(
                      MaterialPageRoute(
                        builder: (context) => MyHomePage(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.arrow_back_ios_rounded),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 85),
                  child: Text(
                    'Recently Played',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
            // const SizedBox(
            //   height: 50,
            // ),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: recentlyNotifier,
                builder: (context, resentList, child) {
                  return ListView.builder(
                    itemCount: resentList.length <= 10 ? resentList.length : 10,
                    itemBuilder: (context, index) {
                      var _songs = resentList[index];
                      bool _isfav = isFavsong(_songs);
                      return InkWell(
                        onTap: () {
                          PlayingAudio(resentList, index);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => NowPlayingScreen(),
                            ),
                          );
                        },
                        child: SizedBox(
                          height: 90,
                          child: Card(
                            child: Center(
                              child: ListTile(
                                iconColor: Colors.amber,
                                leading: const Icon(
                                  Icons.music_video_sharp,
                                  size: 40,
                                ),
                                title: Text(
                                  resentList[index].songname ?? "song name",
                                  overflow: TextOverflow.ellipsis,
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        setState(
                                          () {
                                            if (!_isfav) {
                                              addtofav(_songs);
                                              _isfav = !_isfav;
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content:
                                                      Text('Added to Favorite'),
                                                ),
                                              );
                                            } else {
                                              deletefav(_songs);
                                              _isfav = !_isfav;
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      'Removed from favorite'),
                                                ),
                                              );
                                            }
                                            getAll();
                                          },
                                        );
                                      },
                                      icon: Icon(_isfav
                                          ? Icons.favorite
                                          : Icons.favorite_border),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                PlaylistBottomSheet(
                                                    music: _songs),
                                          ),
                                        );
                                      },
                                      icon: Icon(Icons.library_music_outlined),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
