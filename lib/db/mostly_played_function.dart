import 'package:fine_tune/db/all_songs_funtion.dart';
import 'package:fine_tune/model/model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

ValueNotifier<List<AudioModel>> mostlyplayednotifier = ValueNotifier([]);
addmostplayed(AudioModel song) async {
  final mostplayedDb = await Hive.openBox<int>('Mostly');
  int count = (mostplayedDb.get(song.songId) ?? 0) + 1;
  // log('count${(mostplayedDb.get(song.songId) ?? 0) + 1}');
  mostplayedDb.put(song.songId, count);
  if (count > 4 && !mostlyplayednotifier.value.contains(song)) {
    mostlyplayednotifier.value.add(song);
  }
  if (mostlyplayednotifier.value.length > 10) {
    mostlyplayednotifier.value = mostlyplayednotifier.value.sublist(0, 10);
  }
}

mostlyfetch() async {
  final mostplayedDb = await Hive.openBox<int>('Mostly');
  if (mostplayedDb.isEmpty) {
    for (AudioModel element in allsongNotifer.value) {
      mostplayedDb.put(element.songId, 0);
    }
  } else {
    for (int id in mostplayedDb.keys) {
      int count = mostplayedDb.get(id) ?? 0;
      if (count > 4) {
        for (AudioModel element in allsongNotifer.value) {
          if (element.songId == id) {
            mostlyplayednotifier.value.add(element);

            break;
          }
        }
      }
    }

    if (mostlyplayednotifier.value.length > 10) {
      mostlyplayednotifier.value = mostlyplayednotifier.value.sublist(0, 10);
    }
  }
}

// mostlyfetch() async {
//   final mostplayedDb = await Hive.openBox<int>('Mostly');

//   if (mostplayedDb.isEmpty) {
//     // No data in the box
//     // Perform appropriate action, e.g., handle empty case
//   } else {
//     // Create a list to hold the AudioModel objects
//     List<AudioModel> sortedList = [];

//     // Retrieve and sort the data from the box
//     for (int id in mostplayedDb.keys) {
//       int count = mostplayedDb.get(id) ?? 0;
//       if (count > 4) {
//         for (AudioModel element in allsongNotifer.value) {
//           if (element.songId == id) {
//             sortedList.add(element);
//             break;
//           }
//         }
//       }
//     }
//     sortedList.sort((a, b) {
//       // Sort the list in descending order based on count
//       int countA = mostplayedDb.get(a.songId) ?? 0;
//       int countB = mostplayedDb.get(b.songId) ?? 0;
//       return countB.compareTo(countA);
//     });

//     // Limit the list to 10 items
//     if (sortedList.length > 10) {
//       sortedList = sortedList.sublist(0, 10);
//     }

//     // Display the sorted list of songs
//     for (AudioModel element in sortedList) {
//       print('${element.songname}: ${mostplayedDb.get(element.songId)}');
//     }
//   }
// }
