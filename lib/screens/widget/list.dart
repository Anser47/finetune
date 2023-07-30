// import 'dart:developer';

import 'dart:developer';

import 'package:fine_tune/application/favorite_bloc/favorites_bloc.dart';
import 'package:fine_tune/db/all_songs_funtion.dart';
import 'package:fine_tune/audio.dart';
import 'package:fine_tune/db/fav_function.dart';
import 'package:fine_tune/model/model.dart';
import 'package:fine_tune/screens/playlist/playlistbottomsheet.dart';
import 'package:fine_tune/screens/widget/nowplayin.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../application/search_bloc/search_bloc.dart';

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
    return Scaffold(body: BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return ListView.separated(
            itemBuilder: (context, index) {
              var song = state.songModelistBloc[index];
              bool isLike = isFavsong(song);
              return BlocProvider<FavoritesBloc>(
                create: (context) => FavoritesBloc(),
                child: SongsListWidget(
                  allsongsList: state.songModelistBloc,
                  song: song,
                  index: index,
                  isLike: isLike,
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
            itemCount: state.songModelistBloc.length);
      },
    ));
  }
}

class SongsListWidget extends StatefulWidget {
  const SongsListWidget(
      {super.key,
      required this.allsongsList,
      required this.isLike,
      required this.song,
      required this.index});
  final List<AudioModel> allsongsList;
  final bool isLike;
  final AudioModel song;

  final int index;
  @override
  State<SongsListWidget> createState() => _SongsListWidgetState();
}

class _SongsListWidgetState extends State<SongsListWidget> {
  @override
  Widget build(BuildContext context) {
    context.read<FavoritesBloc>().add(FavCheckEvent(widget.song));
    getAll();
    return InkWell(
      onTap: () {
        PlayingAudio(widget.allsongsList, widget.index);
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
                      child: BlocBuilder<FavoritesBloc, FavoritesState>(
                        builder: (context, state) {
                          log(state.isfav.toString());
                          return IconButton(
                            onPressed: () {
                              context.read<FavoritesBloc>().add(
                                    AddToFavoriteEvent(
                                        //  song: widget.song,
                                        song: widget.song),
                                  );
                              // state.favStateList.contains(widget.song);

                              // setState(
                              //   () {
                              //     if (!widget.isLike) {
                              //       addtofav(widget.song);
                              //       widget.isLike = !widget.isLike;
                              //       ScaffoldMessenger.of(context).showSnackBar(
                              //         const SnackBar(
                              //           content: Text('Added to Favorite'),
                              //         ),
                              //       );
                              //     } else {
                              //       deletefav(widget.song);
                              //       widget.isLike = !widget.isLike;
                              //       ScaffoldMessenger.of(context).showSnackBar(
                              //         const SnackBar(
                              //           content: Text('Removed from favorite'),
                              //         ),
                              //       );
                              //     }
                              //   },
                              // );
                            },
                            icon: Icon(state.isfav
                                ? Icons.favorite
                                : Icons.favorite_border),
                          );
                        },
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
