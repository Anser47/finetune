import 'package:fine_tune/audio.dart';
import 'package:fine_tune/db/fav_function.dart';
import 'package:fine_tune/db/mostly_played_function.dart';
import 'package:fine_tune/screens/bottoman.dart';
import 'package:fine_tune/screens/playlist/playlistbottomsheet.dart';
import 'package:fine_tune/screens/widget/nowplayin.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ScreenMostplayed extends StatefulWidget {
  const ScreenMostplayed({super.key});

  @override
  State<ScreenMostplayed> createState() => _ScreenMostplayedState();
}

class _ScreenMostplayedState extends State<ScreenMostplayed> {
  late Box<int> mostlyBox;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mostlyBox = Hive.box<int>("Mostly");
    setState(
      () {
        getAll();
      },
    );
  }

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
                      MaterialPageRoute(builder: (context) => MyHomePage()),
                    );
                  },
                  icon: const Icon(Icons.arrow_back_ios_rounded),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 85),
                  child: Text(
                    'Mostly Played',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
            const SizedBox(
              child: Text(''),
            ),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: mostlyplayednotifier,
                builder: (context, value, child) {
                  return ListView.builder(
                    itemCount: mostlyplayednotifier.value.length,
                    itemBuilder: (context, index) {
                      var _songs = value[index];
                      bool _isfav = isFavsong(_songs);
                      return InkWell(
                        onTap: () {
                          PlayingAudio(value, index);
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
                                  mostlyplayednotifier.value[index].songname ??
                                      "song name",
                                  overflow: TextOverflow.ellipsis,
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
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
                                        });
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
                                      icon: const Icon(
                                          Icons.library_music_outlined),
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
