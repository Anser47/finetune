import 'package:fine_tune/audio.dart';
import 'package:fine_tune/db/all_songs_funtion.dart';
import 'package:fine_tune/model/model.dart';
import 'package:fine_tune/screens/Widget/list.dart';
import 'package:fine_tune/screens/Widget/nowplayin.dart';
import 'package:flutter/material.dart';

class ScreenSearch extends StatefulWidget {
  const ScreenSearch({super.key});

  @override
  State<ScreenSearch> createState() => _ScreenSearchState();
}

class _ScreenSearchState extends State<ScreenSearch> {
  final TextEditingController searchControll = TextEditingController();

  ValueNotifier<List<AudioModel>> data = ValueNotifier([]);

  void search(String quary, ValueNotifier<List<AudioModel>> data) {
    data.value = allsongNotifer.value
        .where((element) => element.songname!
            .toLowerCase()
            .contains(quary.toLowerCase().trim()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
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
                          setState(() {
                            search(value, data);
                          });
                        },
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          searchControll.clear();
                          setState(() {
                            CustomWidget();
                          });
                        },
                        icon: Icon(Icons.clear))
                  ],
                ),
              ),
            ),
            Expanded(
              child: searchControll.text.isEmpty ||
                      searchControll.text.trim().isEmpty
                  ? const CustomWidget()
                  : data.value.isEmpty
                      ? emptySearch()
                      : searchfound(context, data),
            ),
          ],
        ),
      ),
    );
  }
}

searchfound(context, ValueNotifier<List<AudioModel>> data) {
  return ListView.builder(
    itemCount: data.value.length,
    itemBuilder: (context, index) => InkWell(
      onTap: () {
        // }
        PlayingAudio(data.value, index);
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
                data.value[index].songname!,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.favorite_border),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.library_music_outlined),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
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
