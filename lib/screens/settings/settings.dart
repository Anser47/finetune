import 'package:fine_tune/screens/bottoman.dart';
import 'package:fine_tune/screens/settings/aboutus.dart';
import 'package:fine_tune/screens/settings/privacypolicy.dart';
import 'package:fine_tune/screens/settings/termsandconditons.dart';
import 'package:flutter/material.dart';

class ScreenSettings extends StatelessWidget {
  const ScreenSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => MyHomePage(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 110.0),
                  child: Text(
                    'Settings',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            // TextButton(
            //   onPressed: () {},
            //   child: const Padding(
            //     padding: EdgeInsets.only(left: 25.0, top: 30),
            //     child: Text(
            //       'Profile',
            //       style: TextStyle(fontSize: 25, color: Colors.white),
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 25.0, top: 30),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       TextButton(
            //         onPressed: () {},
            //         child: const Text(
            //           'Dark Mode',
            //           style: TextStyle(fontSize: 25, color: Colors.white),
            //         ),
            //       ),
            //       Switch(value: true, onChanged: (value) {}),
            //     ],
            //   ),
            // ),
            TextButton(
              onPressed: () {},
              child: const Padding(
                padding: EdgeInsets.only(left: 25.0, top: 30),
                child: Text(
                  'Share App',
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ScreenAboutUs(),
                  ),
                );
              },
              child: const Padding(
                padding: EdgeInsets.only(left: 25.0, top: 30),
                child: Text(
                  'About Us',
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ScreenPivacy(),
                  ),
                );
              },
              child: const Padding(
                padding: EdgeInsets.only(left: 25.0, top: 30),
                child: Text(
                  'Privacy Policy',
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => TermsConditionsPage(),
                  ),
                );
              },
              child: const Padding(
                padding: EdgeInsets.only(left: 25.0, top: 30),
                child: Text(
                  'Terms and Conditions',
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
