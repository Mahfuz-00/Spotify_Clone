import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/domain/usecases/song/get_news_songs.dart';
import 'package:spotify/presentation/home/bloc/news_songs_state.dart';
import '../../../service_locator.dart';

/// Cubit that manages the state for news songs.
class NewsSongsCubit extends Cubit<NewsSongsState> {

  /// Initializes the cubit with a loading state.
  NewsSongsCubit() : super(NewsSongsLoading());

  /// Fetches news songs from the use case.
  Future<void> getNewsSongs() async {
    // Call the GetNewsSongs use case to fetch songs
    var returnedSongs = await sl<GetNewsSongsUseCase>().call();

    // Handle the result of the API call
    returnedSongs.fold(
            (failure) {
          // If there is a failure, emit a loading failure state
          emit(NewsSongsLoadFailure());
        },
            (data) {
          // If successful, emit the loaded state with songs data
          emit(NewsSongsLoaded(songs: data));
        }
    );
  }
}
