import 'package:dartz/dartz.dart';
import 'package:spotify/data/sources/song/song_firebase_service.dart';
import 'package:spotify/domain/repository/song/song.dart';
import '../../../service_locator.dart';

/// Implementation of the [SongsRepository] interface.
///
/// This class handles the interaction with the song-related data sources
/// using the [SongFirebaseService] to perform operations such as fetching
/// new songs, managing playlists, and handling user favorites.
class SongRepositoryImpl extends SongsRepository {

  @override
  Future<Either> getNewsSongs() async {
    // Calls the getNewsSongs method of SongFirebaseService to fetch new songs.
    return await sl<SongFirebaseService>().getNewsSongs();
  }

  @override
  Future<Either> getPlayList() async {
    // Calls the getPlayList method of SongFirebaseService to fetch playlists.
    return await sl<SongFirebaseService>().getPlayList();
  }

  @override
  Future<Either> addOrRemoveFavoriteSongs(String songId) async {
    // Calls the addOrRemoveFavoriteSong method to manage favorite status for a song.
    return await sl<SongFirebaseService>().addOrRemoveFavoriteSong(songId);
  }

  @override
  Future<bool> isFavoriteSong(String songId) async {
    // Calls the isFavoriteSong method to check if a song is a favorite.
    return await sl<SongFirebaseService>().isFavoriteSong(songId);
  }

  @override
  Future<Either> getUserFavoriteSongs() async {
    // Calls the getUserFavoriteSongs method to fetch the user's favorite songs.
    return await sl<SongFirebaseService>().getUserFavoriteSongs();
  }
}
