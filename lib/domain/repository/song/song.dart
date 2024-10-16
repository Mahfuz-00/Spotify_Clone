import 'package:dartz/dartz.dart';
/// An abstract class representing the songs repository.
///
/// This repository provides methods for managing songs,
/// including retrieving new songs, playlists, and user favorite songs.
///
/// Methods:
/// - [getNewsSongs]: Retrieves a list of new songs.
/// - [getPlayList]: Retrieves the user's playlist.
/// - [addOrRemoveFavoriteSongs]: Adds or removes a song from the user's favorites using the provided [songId].
/// - [isFavoriteSong]: Checks if a specific song is marked as favorite.
/// - [getUserFavoriteSongs]: Retrieves a list of the user's favorite songs.
abstract class SongsRepository {

  /// Retrieves a list of new songs.
  ///
  /// Returns an [Either] representing the success or failure of the operation.
  Future<Either> getNewsSongs();

  /// Retrieves the user's playlist.
  ///
  /// Returns an [Either] representing the success or failure of the operation.
  Future<Either> getPlayList();

  /// Adds or removes a song from the user's favorites.
  ///
  /// Takes the [songId] of the song to be added or removed.
  /// Returns an [Either] representing the success or failure of the operation.
  Future<Either> addOrRemoveFavoriteSongs(String songId);

  /// Checks if a specific song is marked as favorite.
  ///
  /// Takes the [songId] of the song to check.
  /// Returns true if the song is favorite, otherwise false.
  Future<bool> isFavoriteSong(String songId);

  /// Retrieves a list of the user's favorite songs.
  ///
  /// Returns an [Either] representing the success or failure of the operation.
  Future<Either> getUserFavoriteSongs();
}
