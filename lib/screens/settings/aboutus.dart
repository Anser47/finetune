import 'package:flutter/material.dart';

class ScreenAboutUs extends StatelessWidget {
  const ScreenAboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
      ),
      body: const SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(18.0),
              child: Expanded(
                child: Text(
                    'Welcome to our local database music app! We are dedicated to providing you with a seamless'
                    'and immersive music experience right at your fingertips. With our app, you can explore,'
                    'discover, and enjoy your favorite tunes like never before.'
                    'At our core, we understand the importance of personalized music curation. That is why we have'
                    ' designed our app to allow you to create and manage your playlists effortlessly. Whether you are'
                    'in the mood for an energizing workout session, a relaxing evening at home, or a road trip with'
                    ' friends, our app empowers you to curate the perfect soundtrack for any moment.'
                    'Finding the music you love has never been easier. With our powerful search functionality, you'
                    'can quickly explore our extensive local database of songs, artists, and albums. Simply enter a'
                    'keyword, and our app will present you with a comprehensive list of matching results, allowing'
                    'you to dive deeper into your music preferences.'
                    'We understand that music holds a special place in your heart, and that is why we have incorporated '
                    'a favorite feature into our app. When you come across a song that resonates with you on a profound level,'
                    'simply add it to your favorites. This way, you can easily revisit and relive those cherished musical moments'
                    'whenever you desire.'
                    'Listening to music is a personal experience, and our app ensures that you have complete '
                    ' control over your audio journey. With our sleek and intuitive interface, you can play, pause, skip, and '
                    'repeat your favorite tracks effortlessly. You can also adjust the volume and customize the equalizer settings'
                    'to enhance your listening experience according to your preferences.'
                    'Our local database music app is more than just a platform for listening to music'
                    'it is a gateway to a world of sonic exploration and expression. We invite you to join our vibrant community'
                    'of music enthusiasts, where you can share your favorite playlists, discover new artists, and connect with'
                    'like-minded individuals who share your passion for music.'
                    'So, dive into the world of melodies and rhythms with our local database music app. Let the music surround you,'
                    'inspire you, and be your constant companion. Welcome to a limitless audio adventure!'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
