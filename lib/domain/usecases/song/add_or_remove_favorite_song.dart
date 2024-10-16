import 'package:dartz/dartz.dart';
import 'package:spotify/core/usecase/usecase.dart';

import '../../../service_locator.dart';
import '../../repository/song/song.dart';

/// A use case for adding or removing a song from the user's favorites.
///
/// This class implements the [UseCase] interface and interacts
/// with the [SongsRepository] to manage a user's favorite songs.
class AddOrRemoveFavoriteSongUseCase implements UseCase<Either, String> {

  /// Calls the [SongsRepository] to add or remove a song from the user's favorites.
  ///
  /// [params] must not be null and should contain the ID of the song to be
  /// added or removed from favorites.
  /// Returns an [Either] representing the success or failure of the operation.
  @override
  Future<Either> call({String? params}) async {
    return await sl<SongsRepository>().addOrRemoveFavoriteSongs(params!);
  }
}
