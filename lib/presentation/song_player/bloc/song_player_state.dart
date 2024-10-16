// Abstract class representing the base state for the SongPlayer.
// This allows for easy extension and categorization of song player states.
abstract class SongPlayerState {}

// State indicating that the song player is in the process of loading a song.
// Typically used when initializing the player or fetching the song data.
class SongPlayerLoading extends SongPlayerState {}

// State indicating that the song has been successfully loaded and is ready for playback.
// This state signifies that the player has completed loading the audio and is prepared for user interaction.
class SongPlayerLoaded extends SongPlayerState {}

// State indicating that there was an error loading the song or performing an audio operation.
// This state can be used to inform the user of issues like invalid URLs, network errors, etc.
class SongPlayerFailure extends SongPlayerState {}
