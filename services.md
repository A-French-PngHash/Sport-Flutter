# Services
This documents provides an explanation of the different services used inside the app.

## ImageService

ImageService can be found at [image_service.dart](lib/Cubits/on_going_workout/image_service.dart). This Service allows for an easy way to access exercise's images. During an exercise, multiple images follow closely each other to demonstrate to the user what they need to do (just like a gif but without being one).
This service has a useful method called `startFor` which will automatically keep track of the current image to show, and send an event whenever this image needs to change. 
**Fun Fact :** at that point I was thinking of doing a second layer of cubit just for the image service to send events back (cuz thats kind of the basics of cubits/blocks), would have been a fun thing to do lol but it would be waaaay more complex than it needs to be 😂

It also has methods like `stop` (to basically, stop the `startFor` loop). And `firstImageFor` which is a handy way of getting the first image of an exercise. This is often used when there need to be a placeholder on screen eg. the exercise is being announced.

## ExerciseTracker
Another useful service to keep track of the current exercise and switch between them. It is found at [exercise_tracker.dart](lib/Cubits/on_going_workout/exercise_tracker.dart). This `ExerciseTracker` communicates with the local repositories ([exercise_repository.dart](lib/Data/exercise_repository.dart)) to fetch exercises. It has a method `next` to load the next exercise, and an `isLast` property which says whether the current exercise is the last for the workout being done. 
It currently doesn't have a `previous` method, but it won't stay like that for too long 👀.

*Note* : This service is also responsible for shuffling the exercise list (which is shuffles every time a workout begin).

## SportAudioPlayer

This service is what powers the Audio of the app ! It is found at [audio_players.dart](lib/AudioPlayers/audio_players.dart). It uses a dependency called `flutter_tts` to do, well, Text To Speech. It has preset announcements for different situations (end of a set, beginning of an exercise...).