import 'package:cloud_firestore/cloud_firestore.dart';

/// A class representing a song entity.
///
/// This class contains information about a song, including:
/// - [title]: The title of the song.
/// - [artist]: The artist of the song.
/// - [duration]: The duration of the song in seconds.
/// - [releaseDate]: The release date of the song as a [Timestamp].
/// - [isFavorite]: Indicates whether the song is marked as a favorite.
/// - [songId]: A unique identifier for the song.
class SongEntity {
  final String title;        // The title of the song
  final String artist;       // The artist of the song
  final num duration;        // The duration of the song in seconds
  final Timestamp releaseDate; // The release date of the song
  final bool isFavorite;     // Indicates if the song is marked as a favorite
  final String songId;       // Unique identifier for the song

  SongEntity({
    required this.title,
    required this.artist,
    required this.duration,
    required this.releaseDate,
    required this.isFavorite,
    required this.songId,
  });
}
