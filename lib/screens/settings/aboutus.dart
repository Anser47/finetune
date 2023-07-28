import 'package:flutter/material.dart';

class Aboutus extends StatelessWidget {
  const Aboutus({super.key});

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.black,
      body: const SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Text(
                        'Welcome to fine tune - Your Ultimate Local Storage Music App!',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Our mission at fine tune is to put the power of music at your fingertips. Our software is made to improve your musical experience, regardless of whether you're a die-hard music fan, an aspiring musician, or just someone who likes to groove to your favourite tracks.",
                        style: TextStyle(
                          fontSize: 15,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Key Features of fine tune:',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "1. Liberation from Streaming Constraints: Break free from the limitations of streaming services with fine tune. Take full control of your music library by effortlessly uploading, organizing, and storing your entire collection directly on your device. Enjoy uninterrupted access to your favorite tracks, even without an internet connection.\n2. Effortless Organization, Maximum Enjoyment: Experience seamless music organization with fine tune. Craft custom playlists for every mood, genre, or occasion. Effortlessly sort your songs by artist, album, or track name, enabling you to find the perfect song in mere seconds.\n3. Immersive Music Playback: Immerse yourself in an extraordinary listening experience with our meticulously designed music player. Indulge in crystal-clear sound quality and navigate through your tracks effortlessly with our sleek and intuitive interface. Tailor your playback options, shuffle your playlist, and replay your favorite tunes with a single tap.\n4. Personalized Musical Exploration: Embark on an exhilarating musical journey with fine tune. Our app goes beyond by providing personalized recommendations based on your unique listening habits and preferences. Discover new artists, albums, and tracks that perfectly align with your musical taste, expanding your horizons and unearthing hidden gems you may have otherwise overlooked.",
                        style: TextStyle(
                          fontSize: 15,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
