import 'package:flutter_bloc/flutter_bloc.dart'; // Importing the Flutter Bloc package for state management.
import 'package:spotify/common/bloc/favorite_button/favorite_button_state.dart'; // Importing the states for the FavoriteButtonCubit.
import 'package:spotify/domain/usecases/song/add_or_remove_favorite_song.dart'; // Importing the use case for adding or removing favorite songs.
import 'package:spotify/service_locator.dart'; // Importing the service locator for dependency injection.

/// The `FavoriteButtonCubit` class extends `Cubit` to manage the state of a favorite button for songs.
class FavoriteButtonCubit extends Cubit<FavoriteButtonState> {

  /// Initializes the `FavoriteButtonCubit` with an initial state of `FavoriteButtonInitial`.
  FavoriteButtonCubit() : super(FavoriteButtonInitial());

  /// Updates the favorite button state based on the song's ID.
  ///
  /// This method interacts with the use case to add or remove a song from favorites.
  Future<void> favoriteButtonUpdated(String songId) async {

    // Calls the AddOrRemoveFavoriteSong use case with the song ID as a parameter.
    var result = await sl<AddOrRemoveFavoriteSongUseCase>().call(
        params: songId
    );

    // Handles the result of the use case call using a fold to separate success and failure cases.
    result.fold(
          (l) {}, // Handles the failure case (currently does nothing).
          (isFavorite) { // Handles the success case.
        // Emits a new state `FavoriteButtonUpdated` with the updated favorite status of the song.
        emit(
            FavoriteButtonUpdated(
                isFavorite: isFavorite
            )
        );
      },
    );
  }
}

