import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:sport/Data/Model/exercise/exercise.dart';

/// Plays audio anouncment.
class SportAudioPlayer {
  static AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();
  static const String announcmentPath = "assets/Audio/Announcments";

  _play(List<String> paths, Function finished) async {
    final audioSources = paths.map((e) => Audio(e)).toList();
    await audioPlayer.open(Playlist(audios: audioSources));

    audioPlayer.playlistFinished.listen((f) {
      if (f) {
        finished();
      }
    });
  }

  /// Anounce the given exercise.
  ///
  /// This anouncment is done before each exercise, one time.
  announceExercise(Exercise exercise, Function finished) async {
    print("Begin announcment");
    const test = "${announcmentPath}/test.mp3";

    await _play([test, test, test], finished);
  }
}
