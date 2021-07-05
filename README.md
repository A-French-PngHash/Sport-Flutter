# Sport

A fitness application. 

It is a remake of my [previous fitness app](https://github.com/PngHash-Titouan/Sport). This time it will be written in dart (with flutter) to allow for cross platform usage.

## Goals

There is a few different goals around the creation of this app :

- Enable the use of the fitness app on android (which wasn't possible with the previous one).
- Redesign the app for ease of use.
- Optimize app by using new techniques.

## Run it yourself

1. Fetch packages with `flutter pub get`
2. Generate files with `flutter pub run build_runner watch --delete-conflicting-outputs`
3. Run it !

## Exercises - Explained

There is two type of exercise :
 - **length exercises**
 - **reps exercises**

**Where is defined the type of a specific exercise ?** 
When the length field is set in a workout's exercise, then this exercise will be of type length. If it is not set then the field reps  must be set, which means it will be a "reps exercise". Then to differentiate between the two types of reps exercise, we have to look if the repetitionsLength field is set (in exercises.json). 

### Length exercises
Those are exercises that have a fixed length of time. When this time expires, the app will automatically move on to the next exercise. **How to recognize** : Length parameter **is set** (in workouts.json)

### Reps exercises
Reps exercises have a fixed rep number. There is two different approach to having a rep exercise. **How to recognize** : For both of them, the length parameter is not provided and the rep one is (in workouts.json).

The first one is, the app count each rep while the user is doing it. This imposes a rythm for the user to follow. When the count is finished, the app automatically moves to the next exercise. **How to recognize** : repetitionLength (in exercises.json) **is set**.

The second one meanwhile, leaves it to the user to count for himself. The app will just display how many reps he is suppose to do. The user then manually go to the next exercise (by pressing an arrow on the screen). **How to recognize** : repetitionLength (in exercises.json) **is not set**.

## Specifications

### Exercise storage

All the different exercises are stored in one location : lib/Data/exercises.json
The keys are the exercises' names. This is a unique identifier for each exercise. The name of the different medias for this exercise (images and audio) will have this name.

|Key|Type|Purpose|Required|
|--|--|--|--|
|imagesCount|int|Number of images in the assets for this exercise|YES
|repetitionLength|Float|If the exercise has a fixed number of repetitions (so, doesn't have the "length" field) and this field is provided then the App will announce each rep to the user (1, 2, 3, 4...). Once the number of repetitions (defined at runtime) is reached, the exercise will be considered as done. If it is not provided (and the length field also isn't), the exercise will have a fixed number of repetitions (defined at runtime) displayed to the user, for him to do them at his own pace.|NO|

### Workout storage

Workouts are stored in lib/Data/exercises.json. 
This file contains a "workouts" element which is a list of all the different workouts :

|Key|Type|Purpose|Required
|--|--|--|--|
|name|String|Name of the workout|YES
|exercises|List|List of exercises. Is a dictionary. The specifications for this dictionary are outlined in the [next section](#exercise_list_row)|YES
|restTime|Int|Rest time between exercises. Does not include exercise announcement time|YES
|workoutType|String|Type of the workout amongst the following ones : abs, arm, lowerBody |YES

### Exercise list row <a name="exercise_list_row"></a>

This is the specification for each row of the exercise list. This list is present in every workout object. Each row is a dictionary.
|Key|Type|Purpose|Required
|--|--|--|--|
|name|String|Names inputted in here must be present in exercises.json.|YES
|length|Int|Number of seconds the exercise should last.|NO
|reps|Int|Number of repetition.|NO
|sets|Int|Number of set. Each set contains the given number of repetition|YES

Either (length) *or* (repetitions) must be provided.
