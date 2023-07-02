import 'package:fine_tune/db/all_songs_funtion.dart';
import 'package:fine_tune/db/playlist_function.dart';
import 'package:fine_tune/model/model.dart';
import 'package:fine_tune/model/playlistmode.dart';
import 'package:fine_tune/screens/Widget/nowplayin.dart';
import 'package:flutter/material.dart';

import '../../audio.dart';

class ListScreen extends StatelessWidget {
  final int idx;
  final PlayListModelclass listIndex;
  ListScreen({required this.idx, required this.listIndex, super.key});
  AudioModel song = allsongNotifer.value[0];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              _showPopupMenu(context);
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: eachlist,
        builder: (context, value, child) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  PlayingAudio(listIndex.playlistall!, index);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => NowPlayingScreen(),
                    ),
                  );
                },
                child: SizedBox(
                  height: 90,
                  width: 355,
                  child: Card(
                    child: Center(
                      child: ListTile(
                        iconColor: Colors.amber,
                        leading: const Icon(Icons.music_video_sharp, size: 40),
                        title: Row(
                          children: [
                            Expanded(
                              child: Text(
                                listIndex.playlistall?[index].songname ??
                                    "song name",
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.favorite)),
                            IconButton(
                                onPressed: () {
                                  playlistRemoveSong(
                                      listIndex.playlistall?[index] ?? song,
                                      listIndex);
                                },
                                icon: const Icon(Icons.remove_circle))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
            itemCount: listIndex.playlistall?.length ?? 0,
          );
        },
      ),
    );
  }

  void _showPopupMenu(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.black,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (BuildContext context) {
        return ValueListenableBuilder(
          valueListenable: allsongNotifer,
          builder: (context, values, child) {
            return ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      values[index].songname!,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        songAddTOPlaylist(
                            allsongNotifer.value[index],
                            listIndex.playlistall?[index].songname ??
                                'song name',
                            context);

                        eachlist.value[idx].playlistall
                            ?.add(allsongNotifer.value[index]);
                      },
                      icon: const Icon(Icons.add),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemCount: values.length);
          },
        );
      },
    );
  }
}
