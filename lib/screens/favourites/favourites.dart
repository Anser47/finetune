import 'package:fine_tune/audio.dart';
import 'package:fine_tune/db/fav_function.dart';
import 'package:fine_tune/model/model.dart';
import 'package:fine_tune/screens/Widget/nowplayin.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class Screenfav extends StatefulWidget {
  const Screenfav({super.key});

  @override
  State<Screenfav> createState() => _ScreenfavState();
}

class _ScreenfavState extends State<Screenfav> {
  late Box<AudioModel> favSongBox;
  @override
  void initState() {
    super.initState();
    favSongBox = Hive.box('All');
  }

  @override
  Widget build(BuildContext context) {
    getAll();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 250,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/Picture5.jpg'),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 70,
              child: const Center(
                child: Text(
                  'Favorite',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: addfav,
                builder: (context, List<AudioModel> favAudio, child) {
                  return ListView.separated(
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {},
                          child: InkWell(
                            onTap: () {
                              PlayingAudio(favAudio, index);

                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => NowPlayingScreen(),
                                ),
                              );
                            },
                            child: ListTile(
                              leading: const Icon(Icons.music_video_sharp),
                              iconColor: Colors.amber,
                              title: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      favAudio[index].songname!,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              subtitle:
                                  Text(favAudio[index].artist ?? 'unknown'),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      deletefav(
                                        favAudio[index],
                                      );
                                    },
                                    icon: Icon(Icons.favorite),
                                    color: Colors.red,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider();
                      },
                      itemCount: favAudio.length);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
