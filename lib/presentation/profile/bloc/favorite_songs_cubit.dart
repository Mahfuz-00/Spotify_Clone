import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/domain/entities/song/song.dart';
import 'package:spotify/domain/usecases/song/get_favorite_songs.dart';
import 'package:spotify/presentation/profile/bloc/favorite_songs_state.dart';
import 'package:spotify/service_locator.dart';

/// Cubit to manage the state of favorite songs.
class FavoriteSongsCubit extends Cubit<FavoriteSongsState> {
  FavoriteSongsCubit() : super(FavoriteSongsLoading()); // Initialize the cubit in a loading state

  List<SongEntity> favoriteSongs = []; // List to hold favorite songs

  /// Fetches the favorite songs using the GetFavoriteSongsUseCase.
  Future<void> getFavoriteSongs() async {
    // Call the use case to get favorite songs
    var result = await sl<GetFavoriteSongsUseCase>().call();

    // Handle the result of the use case
    result.fold(
          (l) {
        // If there was an error, emit the failure state
        emit(FavoriteSongsFailure());
      },
          (r) {
        // If successful, update the favoriteSongs list and emit the loaded state
        favoriteSongs = r;
        emit(FavoriteSongsLoaded(favoriteSongs: favoriteSongs));
      },
    );
  }

  /// Removes a song from the favorite songs list by its index.
  ///
  /// [index] The index of the song to remove.
  void removeSong(int index) {
    favoriteSongs.removeAt(index); // Remove the song at the specified index
    emit(FavoriteSongsLoaded(favoriteSongs: favoriteSongs)); // Emit the updated list
  }
}
