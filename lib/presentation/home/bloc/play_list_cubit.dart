import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/song/get_play_list.dart';
import '../../../service_locator.dart';
import 'play_list_state.dart';

/// Cubit for managing the state of the playlist feature.
class PlayListCubit extends Cubit<PlayListState> {

  /// Initializes the cubit with a loading state.
  PlayListCubit() : super(PlayListLoading());

  /// Fetches the playlist using the GetPlayListUseCase.
  Future<void> getPlayList() async {
    // Calls the use case to get the playlist.
    var returnedSongs = await sl<GetPlayListUseCase>().call();

    // Handles the result using a fold pattern.
    returnedSongs.fold(
      // If there's a failure, emit the PlayListLoadFailure state.
          (l) {
        emit(PlayListLoadFailure());
      },
      // If successful, emit the PlayListLoaded state with the list of songs.
          (data) {
        emit(PlayListLoaded(songs: data));
      },
    );
  }
}
