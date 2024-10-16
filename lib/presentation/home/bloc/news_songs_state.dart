import 'package:spotify/domain/entities/song/song.dart';

/// Abstract base class for the states of the NewsSongs feature.
abstract class NewsSongsState {}

/// State representing that news songs are currently being loaded.
class NewsSongsLoading extends NewsSongsState {}

/// State representing successfully loaded news songs.
class NewsSongsLoaded extends NewsSongsState {
  final List<SongEntity> songs; // List of songs that were loaded.

  /// Constructor for NewsSongsLoaded state, requiring a list of songs.
  NewsSongsLoaded({required this.songs});
}

/// State representing a failure to load news songs.
class NewsSongsLoadFailure extends NewsSongsState {}
