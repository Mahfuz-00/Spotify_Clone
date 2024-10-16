import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:spotify/presentation/song_player/bloc/song_player_state.dart';

// The SongPlayerCubit class manages the state of the audio player using the BLoC pattern.
class SongPlayerCubit extends Cubit<SongPlayerState> {

  // Instance of AudioPlayer from the just_audio package for handling audio playback.
  AudioPlayer audioPlayer = AudioPlayer();

  // Variables to track the duration and current position of the song.
  Duration songDuration = Duration.zero;
  Duration songPosition = Duration.zero;

  // Constructor initializes the cubit state as loading and sets up listeners for audio player events.
  SongPlayerCubit() : super(SongPlayerLoading()) {

    // Listening to the audio player's position stream to update the current song position.
    audioPlayer.positionStream.listen((position) {
      songPosition = position; // Update the songPosition variable with the current position.
      updateSongPlayer(); // Emit an update to the state to notify listeners of changes.
    });

    // Listening to the audio player's duration stream to retrieve the total song duration.
    audioPlayer.durationStream.listen((duration) {
      songDuration = duration!; // Update the songDuration variable with the current duration.
    });
  }

  // Method to emit the loaded state of the song player after any relevant update.
  void updateSongPlayer() {
    emit(
        SongPlayerLoaded() // Emit a state indicating the song is loaded and ready.
    );
  }

  // Method to load a song from a provided URL.
  Future<void> loadSong(String url) async {
    print(url); // Print the URL to the console for debugging.
    try {
      // Attempt to set the URL for the audio player to play the song.
      await audioPlayer.setUrl(url);
      emit(
          SongPlayerLoaded() // Emit the loaded state upon successful loading.
      );
    } catch (e) {
      emit(
          SongPlayerFailure() // Emit a failure state if there's an error loading the song.
      );
    }
  }

  // Method to play or pause the current song based on its current state.
  void playOrPauseSong() {
    if (audioPlayer.playing) {
      audioPlayer.stop(); // Stop the audio if it's currently playing.
    } else {
      audioPlayer.play(); // Play the audio if it's currently stopped.
    }
    emit(
        SongPlayerLoaded() // Emit the loaded state to reflect the current playback state.
    );
  }

  // Dispose of the audio player when the cubit is closed to free up resources.
  @override
  Future<void> close() {
    audioPlayer.dispose(); // Dispose of the audio player to prevent memory leaks.
    return super.close(); // Call the superclass close method.
  }
}
