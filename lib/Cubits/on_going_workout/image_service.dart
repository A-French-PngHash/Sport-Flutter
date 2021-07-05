import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:sport/Data/Model/exercise/exercise.dart';

/// Responsible for the displaying of the correct images in an exercise.
class ImageService {
  int currentImageIndex = 0;
  Exercise? currentExercise;
  String extension = "jpeg";

  Timer? currentTimer;
  Map<String, String> imagePathMap;

  ImageService._create(this.imagePathMap);

  static Future<ImageService> create() async {
    final component = ImageService._create(await _getImagePaths());
    return component;
  }

  /// Start the displaying of images for the exercise given.
  ///
  /// - exercise : The exercise to start the displaying of images for.
  /// - imageChanged : Function called when the image changed.
  void startFor(Exercise exercise, void imageChanged(String imageUrl)) {
    double imageDisplayTime = 1;
    currentImageIndex = 1;
    if (exercise.repetitionLength != null && exercise.reps != null) {
      // We know the time between each rep. It is possible to adjust the time the images get displayed.
      imageDisplayTime = exercise.repetitionLength! / exercise.reps!;
    }
    currentExercise = exercise;
    currentTimer = Timer.periodic(Duration(milliseconds: (imageDisplayTime * 1000).floor()), (timer) {
      currentImageIndex += 1;
      if (currentImageIndex > exercise.imagesCount) {
        // Reached the last image, starting again.
        currentImageIndex = 1;
      }
      imageChanged(currentImage);
    });
  }

  String get currentImage {
    return _urlFor(currentImageIndex);
  }

  /// Stop changing images.
  stop() {
    currentExercise = null;
    if (currentTimer != null) {
      currentTimer!.cancel();
      currentTimer = null;
    }
  }

  /// Returns the first image for the given exercise.
  String firstImageFor(Exercise exercise) {
    return _urlFor(1, exercise: exercise);
  }

  /// Return the path to the current exercise image.
  ///
  /// - image_index : The index of the image to show. Exercises often have
  /// multiple images.
  /// - exercise : If provided will return the path for this exercise given. Otherwise
  /// the current exercise set in the currentExercise variable.
  String _urlFor(int image_index, {Exercise? exercise}) {
    exercise = exercise == null ? currentExercise : exercise;
    final key = exercise!.name + " " + image_index.toString();
    print(imagePathMap.keys);
    if (imagePathMap.containsKey(key) != true) {
      throw Exception("No image in the pathMap for the exercise ${exercise.name} at the image index $image_index");
    }
    return imagePathMap[key]!;
  }
}

/// Returns a map of all the images that are available.
Future<Map<String, String>> _getImagePaths() async {
  final manifestContent = await rootBundle.loadString('AssetManifest.json');
  final Map<String, dynamic> manifestMap = json.decode(manifestContent);
  final imagePaths = manifestMap.keys
      .where((String key) => key.contains('images/'))
      .where((String key) => key.contains('.png'))
      .toList();

  Map<String, String> path_map = {};

  for (String i in imagePaths) {
    final key = i.split("/").last.replaceAll("%20", " ").split(".").first;
    path_map[key] = i.replaceAll("%20", " ");
  }
  print(path_map);
  return path_map;
}
