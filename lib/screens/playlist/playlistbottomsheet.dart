import 'package:fine_tune/db/playlist_function.dart';
import 'package:fine_tune/model/model.dart';
import 'package:flutter/material.dart';

import '../bottoman.dart';

// ignore: must_be_immutable
class PlaylistBottomSheet extends StatefulWidget {
  final AudioModel music;
  const PlaylistBottomSheet({required this.music, super.key});

  @override
  State<PlaylistBottomSheet> createState() => _PlaylistBottomSheetState();
}

class _PlaylistBottomSheetState extends State<PlaylistBottomSheet> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _editingplaylist = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Playlist'),
        actions: [
          IconButton(
            onPressed: () {
              // log(eachlist.value.length.toString());
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Add Playlist'),
                    content: TextField(
                      controller: _editingplaylist,
                      decoration:
                          const InputDecoration(labelText: 'Playlist Name'),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          setState(
                            () {
                              String addto = _editingplaylist.text;
                              if (addto.isNotEmpty) {
                                playlistCreate(addto, context);
                                print("playlist added");
                              }
                            },
                          );

                          _editingplaylist.clear();
                          Navigator.of(context).pop();
                        },
                        child: const Text('Add'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancel'),
                      )
                    ],
                  );
                },
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ValueListenableBuilder(
          valueListenable: eachlist,
          builder: (context, value, child) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return (eachlist.value.isNotEmpty)
                    ? Card(
                        child: InkWell(
                          onTap: () {
                            songAddTOPlaylist(
                                widget.music,
                                value[index].playlistName ?? "playlist name",
                                context);

                            // eachlist.value[index].playlistall.add(widget.music);
                            Navigator.of(context).pop(
                              MaterialPageRoute(
                                builder: (context) => MyHomePage(),
                              ),
                            );
                          },
                          child: ListTile(
                            title: Text(
                              eachlist.value[index].playlistName ??
                                  "playlist name",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ),
                      )
                    : Center(
                        child: Text('empty'),
                      );
              },
              itemCount: eachlist.value.length,
            );
          },
        ),
      ),
    );
  }
}
