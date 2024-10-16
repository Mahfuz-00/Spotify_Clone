import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spotify/domain/entities/song/song.dart';

/// A model class representing a song.
///
/// This class is used to create a song object from JSON data
/// and provides a method to convert it to a domain entity.
///
/// It contains the following fields:
/// - [title]: The title of the song.
/// - [artist]: The artist of the song.
/// - [duration]: The duration of the song in seconds.
/// - [releaseDate]: The release date of the song as a [Timestamp].
/// - [isFavorite]: A boolean indicating if the song is a favorite.
/// - [songId]: A unique identifier for the song.
class SongModel {
  String? title;
  String? artist;
  num? duration;
  Timestamp? releaseDate;
  bool? isFavorite;
  String? songId;

  /// Constructor for creating a [SongModel] object.
  ///
  /// All fields are required for the constructor except for optional
  /// fields which can be null.
  SongModel({
    required this.title,
    required this.artist,
    required this.duration,
    required this.releaseDate,
    required this.isFavorite,
    required this.songId,
  });

  /// Factory constructor for creating a [SongModel] from a JSON map.
  ///
  /// This constructor extracts the [title], [artist], [duration],
  /// and [releaseDate] fields from the JSON map.
  SongModel.fromJson(Map<String, dynamic> data) {
    title = data['title'];
    artist = data['artist'];
    duration = data['duration'];
    releaseDate = data['releaseDate'];
  }
}

/// Extension on [SongModel] to convert it to a [SongEntity].
extension SongModelX on SongModel {
  /// Converts the [SongModel] instance to a [SongEntity].
  ///
  /// This method is useful for transforming the model to a
  /// domain layer representation of the song.
  SongEntity toEntity() {
    return SongEntity(
      title: title!,
      artist: artist!,
      duration: duration!,
      releaseDate: releaseDate!,
      isFavorite: isFavorite!,
      songId: songId!,
    );
  }
}
