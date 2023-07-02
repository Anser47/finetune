// import 'dart:developer';

import 'package:fine_tune/db/all_songs_funtion.dart';
import 'package:fine_tune/audio.dart';
import 'package:fine_tune/db/fav_function.dart';
import 'package:fine_tune/model/model.dart';
import 'package:fine_tune/screens/playlist/playlistbottomsheet.dart';
import 'package:fine_tune/screens/widget/nowplayin.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class CustomWidget extends StatefulWidget {
  const CustomWidget({super.key});

  @override
  State<CustomWidget> createState() => _CustomWidgetState();
}

class _CustomWidgetState extends State<CustomWidget> {
  late Box<AudioModel> allsongBox;

  @override
  void initState() {
    super.initState();
    getAllSongs();
    allsongBox = Hive.box('all_song_db');
    getAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: allsongNotifer,
        builder:
            (BuildContext cntx, List<AudioModel> allsongsList, Widget? child) {
          return ListView.separated(
              itemBuilder: (context, index) {
                var song = allsongsList[index];
                bool isLike = isFavsong(song);
                return SongsListWidget(
                  allsongsList: allsongsList,
                  song: song,
                  index: index,
                  isLike: isLike,
                );
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemCount: allsongsList.length);
        },
      ),
    );
  }
}

class SongsListWidget extends StatefulWidget {
  SongsListWidget(
      {super.key,
      required this.allsongsList,
      required this.isLike,
      required this.song,
      required this.index});
  List<AudioModel> allsongsList;
  bool isLike;
  AudioModel song;

  int index;
  @override
  State<SongsListWidget> createState() => _SongsListWidgetState();
}

class _SongsListWidgetState extends State<SongsListWidget> {
  @override
  Widget build(BuildContext context) {
    getAll();
    return InkWell(
      onTap: () {
        PlayingAudio(widget.allsongsList, widget.index);
        // log('songid${widget.allsongsList[widget.index].songId}');
        // log('id${widget.allsongsList[widget.index].id}');
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => NowPlayingScreen(),
          ),
        );
      },
      child: SizedBox(
        width: 355,
        height: 90,
        child: Card(
          child: ListTile(
            leading: const Icon(
              Icons.music_video_sharp,
              size: 40,
            ),
            subtitle: Text(widget.song.artist ?? ' unknown '),
            iconColor: Colors.amber,
            title: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.song.songname!,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Builder(
                  builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: IconButton(
                        onPressed: () {
                          setState(
                            () {
                              if (!widget.isLike) {
                                addtofav(widget.song);
                                widget.isLike = !widget.isLike;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Added to Favorite'),
                                  ),
                                );
                              } else {
                                deletefav(widget.song);
                                widget.isLike = !widget.isLike;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Removed from favorite'),
                                  ),
                                );
                              }
                            },
                          );
                        },
                        icon: Icon(widget.isLike
                            ? Icons.favorite
                            : Icons.favorite_border),
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              PlaylistBottomSheet(music: widget.song),
                        ),
                      );
                    },
                    icon: const Icon(Icons.library_music_outlined),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
