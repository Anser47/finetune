import 'package:fine_tune/db/playlist_function.dart';
import 'package:fine_tune/screens/playlist/listscreen.dart';
import 'package:flutter/material.dart';

class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen({super.key});

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  TextEditingController _playlistEditingController = TextEditingController();
  void _showAddPlaylist() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Playlist'),
          content: TextField(
            controller: _playlistEditingController,
            decoration: const InputDecoration(labelText: 'Playlist Name'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                setState(
                  () {
                    String addPlaylistName = _playlistEditingController.text;
                    if (addPlaylistName.isNotEmpty) {
                      playlistCreate(_playlistEditingController.text, context);
                    }
                  },
                );
                _playlistEditingController.clear();
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _editPlaylist(int index) {
    TextEditingController _editplaylistcontroller = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Playlist'),
          content: TextField(
            controller: _editplaylistcontroller,
            decoration: const InputDecoration(labelText: 'Playlist Name'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                setState(
                  () {
                    String newName = _editplaylistcontroller.text;

                    if (newName.isNotEmpty) {
                      playlistRename(index, newName);
                    }
                    Navigator.of(context).pop();
                  },
                );
              },
              child: const Text('Save'),
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'))
          ],
        );
      },
    );
  }

  void deletePlaylist(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you Sure you want to delete this playlist'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                setState(
                  () {
                    playlistDelete(index);
                  },
                );
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Playlist')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ValueListenableBuilder(
          valueListenable: eachlist,
          builder: (context, value, child) {
            return ListView.separated(
                itemBuilder: (context, index) {
                  return Container(
                    height: 90,
                    child: Card(
                      color: const Color.fromARGB(255, 44, 73, 86),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 2.0,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ListScreen(
                                  listIndex: eachlist.value[index], idx: index),
                            ),
                          );
                        },
                        child: ListTile(
                          leading: const Padding(
                            padding: EdgeInsets.only(top: 9.0),
                            child: Icon(
                              Icons.playlist_play_rounded,
                              size: 60,
                            ),
                          ),
                          title: Padding(
                            padding: const EdgeInsets.only(top: 18.0),
                            child: Text(
                              eachlist.value[index].playlistName ??
                                  "playlist name",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                          trailing: Padding(
                            padding: const EdgeInsets.only(top: 18.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    _editPlaylist(index);
                                  },
                                  icon: const Icon(Icons.edit),
                                ),
                                IconButton(
                                  onPressed: () {
                                    deletePlaylist(index);
                                  },
                                  icon: const Icon(Icons.delete),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, Index) {
                  return const SizedBox(height: 16.0);
                },
                itemCount: eachlist.value.length);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        child: const Icon(Icons.add, color: Colors.black),
        onPressed: () {
          _showAddPlaylist();
        },
      ),
    );
  }
}
