# Sport

A fitness application. 

It is a remake of my [previous fitness app](https://github.com/PngHash-Titouan/Sport). This time it will be written in dart (with flutter) to allow for cross platform usage.

## Goals

There is a few different goals around the creation of this app :

- Enable the use of the fitness app on android (which wasn't possible with the previous one).
- Redesign the app for ease of use.
- Optimize app by using new techniques.

## Specifications

### Exercise storage

All the different exercises are stored in one location : lib/Data/exercises.json
This file contains a "exercises" element which is a list of all the exercise :

|Key|Type|Purpose|Required|
|--|--|--|--|
|name|String|Name of the exercise. This is a unique identifier for the exercise. The name of the different medias for this exercise (images and audio) will have this name.|YES|
|imagesCount|Int|Number of images associated with this exercise. Images show the user how to perform the said exercise.|YES|
|length|Int|Number of seconds the exercise should last. If provided, a timer will be displayed on the interface, the exercise will be considered finished once the timer expires. If not provided then the exercise will be considered as a fixed number of repetitions one.|NO|
|repetitionLength|Float|If the exercise has a fixed number of repetitions (so, doesn't have the "length" field) and this field is provided then the App will announce each rep to the user (1, 2, 3, 4...). Once the number of repetitions (defined at runtime) is reached, the exercise will be considered as done. If it is not provided (and the length field also isn't), the exercise will have a fixed number of repetitions (defined at runtime) displayed to the user, for him to do them at his own pace.|NO|

### Workout storage

Workouts are stored in lib/Data/exercises.json. 
This file contains a "workouts" element which is a list of all the different workouts :

|Key|Type|Purpose|Required
|--|--|--|--|
|name|String|Name of the workout|YES
|exercises|List\<String\>|List of exercises names. Names inputted in here must be present in exercises.json|YES
|restTime|Int|Rest time between exercises. Does not include exercise announcement time|YES
|workoutType|Type of the workout amongst the following ones : abs, arm, lowerBody |YES
