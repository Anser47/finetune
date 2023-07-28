import 'package:fine_tune/audio.dart';
import 'package:fine_tune/db/fav_function.dart';
import 'package:fine_tune/model/model.dart';
import 'package:fine_tune/screens/Widget/list.dart';
import 'package:fine_tune/screens/Widget/nowplayin.dart';
import 'package:fine_tune/screens/playlist/playlistbottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/search_bloc/search_bloc.dart';

class ScreenSearch extends StatefulWidget {
  const ScreenSearch({super.key});

  @override
  State<ScreenSearch> createState() => _ScreenSearchState();
}

class _ScreenSearchState extends State<ScreenSearch> {
  final TextEditingController searchControll = TextEditingController();

  // ValueNotifier<List<AudioModel>> data = ValueNotifier([]);

  // void search(String quary, ValueNotifier<List<AudioModel>> data) {
  //   data.value = allsongNotifer.value
  //       .where((element) => element.songname!
  //           .toLowerCase()
  //           .contains(quary.toLowerCase().trim()))
  //       .toList();
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      getAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    getAll();
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {},
                        ),
                        Expanded(
                          child: TextField(
                            controller: searchControll,
                            decoration: const InputDecoration(
                              hintText: 'Search',
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              context
                                  .read<SearchBloc>()
                                  .add(SeachWord(searchValue: value));
                            },
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            searchControll.clear();
                            setState(
                              () {
                                const CustomWidget();
                              },
                            );
                          },
                          icon: const Icon(Icons.clear),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: searchControll.text.isEmpty ||
                          searchControll.text.trim().isEmpty
                      ? const CustomWidget()
                      : state.songModelistBloc.isEmpty
                          ? emptySearch()
                          : searchfound(context, state.songModelistBloc),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  searchfound(context, List<AudioModel> data) {
    getAll();
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        var _song = data[index];
        bool _isfav = isFavsong(_song);
        return InkWell(
          onTap: () {
            PlayingAudio(data, index);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => NowPlayingScreen(),
              ),
            );
          },
          child: SizedBox(
            height: 90,
            width: 300,
            child: Card(
              child: Center(
                child: ListTile(
                  iconColor: Colors.amber,
                  leading: const Icon(
                    Icons.music_video_sharp,
                    size: 40,
                  ),
                  title: Text(
                    data[index].songname!,
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
                                addtofav(_song);
                                _isfav = !_isfav;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Added to Favorite'),
                                  ),
                                );
                              } else {
                                deletefav(_song);
                                _isfav = !_isfav;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Removed from favorite'),
                                  ),
                                );
                              }
                              getAll();
                            },
                          );
                        },
                        icon: const Icon(Icons.favorite_border),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  PlaylistBottomSheet(music: _song),
                            ),
                          );
                        },
                        icon: const Icon(Icons.library_music_outlined),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

emptySearch() {
  return const SizedBox(
    child: Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'File not found',
            style: TextStyle(fontSize: 20, color: Color(0xFF9C9C9C)),
          )
        ],
      ),
    ),
  );
}
