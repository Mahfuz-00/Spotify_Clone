import 'package:spotify/domain/entities/song/song.dart';

/// Abstract base class representing the different states for favorite songs.
abstract class FavoriteSongsState {}

/// State indicating that favorite songs are currently being loaded.
class FavoriteSongsLoading extends FavoriteSongsState {}

/// State indicating that favorite songs have been successfully loaded.
///
/// This class contains a list of favorite songs.
class FavoriteSongsLoaded extends FavoriteSongsState {
  final List<SongEntity> favoriteSongs; // List of favorite song entities

  /// Constructor to initialize FavoriteSongsLoaded with the list of favorite songs.
  FavoriteSongsLoaded({required this.favoriteSongs});
}

/// State indicating that there was a failure in loading favorite songs.
class FavoriteSongsFailure extends FavoriteSongsState {}
