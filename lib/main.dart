import 'package:fine_tune/model/model.dart';
import 'package:fine_tune/model/playlistmode.dart';
import 'package:flutter/material.dart';
import 'package:fine_tune/screens/splash.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(AudioModelAdapter().typeId)) {
    Hive.registerAdapter(AudioModelAdapter());
  }

  if (!Hive.isAdapterRegistered(PlayListModelclassAdapter().typeId)) {
    Hive.registerAdapter(PlayListModelclassAdapter());
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
