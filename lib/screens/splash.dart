import 'dart:async';
import 'package:fine_tune/db/all_songs_funtion.dart';
import 'package:fine_tune/db/fav_function.dart';
import 'package:fine_tune/db/playlist_function.dart';
import 'package:fine_tune/db/recently_function.dart';
import 'package:fine_tune/screens/audioquwry.dart';
import 'package:fine_tune/screens/bottoman.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    loadData();
    getAll();
    getAllSongs();
    getPlaylist();
    getrecentSongs();
  }

  Future<Timer> loadData() async {
    FetchSongs songFetch = FetchSongs();
    songFetch.songfatch();
    return Timer(const Duration(seconds: 1), navigateToSongs);
  }

  void navigateToSongs() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) => const MyHomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset('assets/images/Picture1.png'),
            ),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
