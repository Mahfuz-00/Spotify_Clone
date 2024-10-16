import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify/data/models/song/song.dart';
import 'package:spotify/domain/entities/song/song.dart';
import 'package:spotify/domain/usecases/song/is_favorite_song.dart';

import '../../../service_locator.dart';

/// Abstract class defining the contract for song-related services.
/// It outlines methods for fetching songs, managing favorites, and retrieving playlists.
abstract class SongFirebaseService {

  /// Retrieves a list of new songs.
  Future<Either> getNewsSongs();

  /// Retrieves the user's playlist.
  Future<Either> getPlayList();

  /// Adds or removes a song from the user's favorites.
  Future<Either> addOrRemoveFavoriteSong(String songId);

  /// Checks if a specific song is marked as a favorite.
  Future<bool> isFavoriteSong(String songId);

  /// Retrieves the user's favorite songs.
  Future<Either> getUserFavoriteSongs();
}

/// Implementation of the SongFirebaseService using Firebase services.
class SongFirebaseServiceImpl extends SongFirebaseService {

  /// Fetches a list of new songs ordered by release date.
  ///
  /// Returns:
  /// - [Right]: List of new songs.
  /// - [Left]: An error message if retrieval fails.
  @override
  Future<Either> getNewsSongs() async {
    try {
      List<SongEntity> songs = [];
      // Fetch songs from Firestore, ordered by release date (newest first)
      var data = await FirebaseFirestore.instance.collection('Songs')
          .orderBy('releaseDate', descending: true)
          .limit(3) // Limit the number of songs to 3
          .get();

      // Loop through each song document retrieved
      for (var element in data.docs) {
        var songModel = SongModel.fromJson(element.data());

        // Check if the song is marked as a favorite
        bool isFavorite = await sl<IsFavoriteSongUseCase>().call(
            params: element.reference.id
        );
        songModel.isFavorite = isFavorite; // Set the favorite status
        songModel.songId = element.reference.id; // Set the song ID

        // Add the song entity to the list
        songs.add(songModel.toEntity());
      }

      return Right(songs); // Return the list of songs wrapped in a Right

    } catch (e) {
      print(e); // Print the error for debugging
      return const Left('An error occurred, Please try again.'); // Return error message
    }
  }

  /// Fetches the user's entire playlist of songs.
  ///
  /// Returns:
  /// - [Right]: List of songs in the playlist.
  /// - [Left]: An error message if retrieval fails.
  @override
  Future<Either> getPlayList() async {
    try {
      List<SongEntity> songs = [];
      // Fetch all songs from Firestore, ordered by release date
      var data = await FirebaseFirestore.instance.collection('Songs')
          .orderBy('releaseDate', descending: true)
          .get();

      // Loop through each song document retrieved
      for (var element in data.docs) {
        var songModel = SongModel.fromJson(element.data());

        // Check if the song is marked as a favorite
        bool isFavorite = await sl<IsFavoriteSongUseCase>().call(
            params: element.reference.id
        );
        songModel.isFavorite = isFavorite; // Set the favorite status
        songModel.songId = element.reference.id; // Set the song ID

        // Add the song entity to the list
        songs.add(songModel.toEntity());
      }

      return Right(songs); // Return the list of songs wrapped in a Right

    } catch (e) {
      print(e); // Print the error for debugging
      return const Left('An error occurred, Please try again.'); // Return error message
    }
  }

  /// Adds a song to the user's favorites or removes it if it already exists.
  ///
  /// Returns:
  /// - [Right]: A boolean indicating the new favorite status.
  /// - [Left]: An error message if the operation fails.
  @override
  Future<Either> addOrRemoveFavoriteSong(String songId) async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      late bool isFavorite;
      var user = firebaseAuth.currentUser;
      String uId = user!.uid; // Get the current user's ID

      // Query to check if the song is already in favorites
      QuerySnapshot favoriteSongs = await firebaseFirestore.collection('Users')
          .doc(uId)
          .collection('Favorites')
          .where('songId', isEqualTo: songId)
          .get();

      // If the song is already a favorite, remove it
      if (favoriteSongs.docs.isNotEmpty) {
        await favoriteSongs.docs.first.reference.delete();
        isFavorite = false; // Set the status to not favorite
      } else { // If the song is not a favorite, add it
        await firebaseFirestore.collection('Users')
            .doc(uId)
            .collection('Favorites')
            .add({
          'songId': songId,
          'addedDate': Timestamp.now() // Add the current timestamp
        });
        isFavorite = true; // Set the status to favorite
      }

      return Right(isFavorite); // Return the new favorite status wrapped in a Right

    } catch (e) {
      print(e); // Print the error for debugging
      return const Left('An error occurred'); // Return error message
    }
  }

  /// Checks if a specific song is marked as a favorite by the user.
  ///
  /// Returns:
  /// - [true]: If the song is a favorite.
  /// - [false]: If the song is not a favorite or an error occurs.
  @override
  Future<bool> isFavoriteSong(String songId) async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      var user = firebaseAuth.currentUser;
      String uId = user!.uid; // Get the current user's ID

      // Query to check if the song is in favorites
      QuerySnapshot favoriteSongs = await firebaseFirestore.collection('Users')
          .doc(uId)
          .collection('Favorites')
          .where('songId', isEqualTo: songId)
          .get();

      // Return true if the song is found in favorites
      return favoriteSongs.docs.isNotEmpty;
    } catch (e) {
      print(e); // Print the error for debugging
      return false; // Return false if an error occurs
    }
  }

  /// Retrieves the user's favorite songs from Firestore.
  ///
  /// Returns:
  /// - [Right]: List of favorite songs.
  /// - [Left]: An error message if retrieval fails.
  @override
  Future<Either> getUserFavoriteSongs() async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      var user = firebaseAuth.currentUser;
      List<SongEntity> favoriteSongs = [];
      String uId = user!.uid; // Get the current user's ID

      // Fetch all favorite songs from the user's collection
      QuerySnapshot favoritesSnapshot = await firebaseFirestore.collection('Users')
          .doc(uId)
          .collection('Favorites')
          .get();

      // Loop through each favorite song document retrieved
      for (var element in favoritesSnapshot.docs) {
        String songId = element['songId'];
        // Fetch the corresponding song details from the Songs collection
        var song = await firebaseFirestore.collection('Songs').doc(songId).get();
        SongModel songModel = SongModel.fromJson(song.data()!);
        songModel.isFavorite = true; // Mark as favorite
        songModel.songId = songId; // Set the song ID

        // Add the song entity to the list
        favoriteSongs.add(songModel.toEntity());
      }

      return Right(favoriteSongs); // Return the list of favorite songs wrapped in a Right

    } catch (e) {
      print(e); // Print the error for debugging
      return const Left('An error occurred'); // Return error message
    }
  }
}
