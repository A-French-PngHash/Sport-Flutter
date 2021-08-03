import 'dart:math';

import 'package:flutter_tts/flutter_tts.dart';
import 'package:sport/Data/Model/exercise/exercise.dart';

/// Plays audio anouncment.
class SportAudioPlayer {
  static const String announcmentPath = "assets/Audio/Announcments";
  late final FlutterTts flutterTts;
  static const congratulationWords = ["Congratulation", "Awesome", "Amazing", "Unbelievable", "Demolition", "Carnage"];

  SportAudioPlayer() {
    flutterTts = FlutterTts();
    flutterTts
        .setIosAudioCategory(IosTextToSpeechAudioCategory.ambient, [IosTextToSpeechAudioCategoryOptions.mixWithOthers]);
    flutterTts.awaitSpeakCompletion(true);
    flutterTts.setSpeechRate(0.56);
    flutterTts.setPitch(1);
    flutterTts.isLanguageAvailable("en-IE").then((available) => {
          if (available) {flutterTts.setLanguage("en-IE")} else {flutterTts.setLanguage("en-US")}
        });
  }

  /// Anounce the given exercise.
  ///
  /// This anouncment is done before each exercise, one time.
  announceExercise(Exercise exercise) async {
    if (exercise.length != null) {
      // Length exercise.
      await flutterTts.speak(
          "Now we have, ${exercise.name}, ${exercise.sets} set${exercise.sets > 1 ? "s" : ""}, of ${exercise.length} seconds, Get ready, and");
    } else {
      await flutterTts.speak(
          "Now we have, ${exercise.name}, ${exercise.sets} set${exercise.sets > 1 ? "s" : ""}, of ${exercise.reps} repetitions, Get ready, and");
    }
  }

  /// Anounce the end of the given exercise.
  ///
  ///
  anounceEndOfExercise(Exercise exercise, int restTime) async {
    final _random = new Random();

    await flutterTts.speak(
        "${congratulationWords[_random.nextInt(congratulationWords.length)]}, now rest for ${restTime}, seconds");
  }

  /// Anounce the next set.
  ///
  /// Is done at the end of each set if another one is coming up.
  ///
  /// - previousSet : The set count
  Future<void> anounceNextSet(Exercise exercise, int currentSet) async {
    await flutterTts
        .speak("Fantastic, Now prepare for the next set, set ${currentSet} of ${exercise.sets}, get ready, and");
    print("end of next set announcment");
  }

  /// Anounce the end of the workout.
  ///
  /// Done once at the end of each workout.
  anounceEndOfWorkout() async {
    await flutterTts.speak("This is the end of this workout, good job !");
  }

  /// Anounce the given number.
  ///
  /// Usually used to count the reps.
  anounceNumber(int number) async {
    await flutterTts.speak(number.toString());
  }

  speak(String texte) async {
    await flutterTts.synthesizeToFile(texte, "temp.mp3");
  }

  /// Stops all announcments currently playing.
  stop() {
    flutterTts.stop();
  }
}
