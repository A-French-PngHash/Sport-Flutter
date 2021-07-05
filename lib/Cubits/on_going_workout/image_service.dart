import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sport/Data/Model/exercise/exercise.dart';

/// Responsible for the displaying of the correct images in an exercise.
class ImageService {
  int currentImageIndex = 0;
  Exercise? currentExercise;
  String extension = "jpeg";

  Timer? currentTimer;

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
    return urlDomainFor()! + "${currentExercise!.name} $currentImageIndex.$extension";
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
    return urlDomainFor(exercise: exercise)! + "${exercise.name} 1.$extension";
  }

  /// Return the url domain for the current exercise's images.
  ///
  /// - exercise : If provided will return the path for this exercise. Otherwise
  /// the current exercise set in the currentExercise variable.
  String? urlDomainFor({Exercise? exercise}) {
    if (exercise != null) {
      return "assets/images/${exercise.name}/";
    }
    if (currentExercise != null) {
      return "assets/images/${currentExercise!.name}/";
    }
  }
}
