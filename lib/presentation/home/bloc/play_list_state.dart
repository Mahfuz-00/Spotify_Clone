import 'package:spotify/domain/entities/song/song.dart';

/// Abstract class representing the different states of the playlist.
abstract class PlayListState {}

// State indicating that the playlist is currently loading.
class PlayListLoading extends PlayListState {}

// State indicating that the playlist has been successfully loaded.
class PlayListLoaded extends PlayListState {
  /// The list of songs that make up the playlist.
  final List<SongEntity> songs;

  /// Constructor for initializing the PlayListLoaded state with songs.
  PlayListLoaded({required this.songs});
}

// State indicating that there was a failure in loading the playlist.
class PlayListLoadFailure extends PlayListState {}
