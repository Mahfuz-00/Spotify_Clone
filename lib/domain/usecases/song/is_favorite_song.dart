import 'package:spotify/core/usecase/usecase.dart';
import '../../../service_locator.dart';
import '../../repository/song/song.dart';

/// A use case for checking if a song is marked as a favorite.
///
/// This class implements the [UseCase] interface and interacts
/// with the [SongsRepository] to determine whether a specified
/// song is a favorite of the user.
class IsFavoriteSongUseCase implements UseCase<bool, String> {

  /// Calls the [SongsRepository] to check if the specified song is a favorite.
  ///
  /// Takes a [String] parameter representing the song ID.
  /// Returns a [bool] indicating whether the song is a favorite.
  @override
  Future<bool> call({String? params}) async {
    return await sl<SongsRepository>().isFavoriteSong(params!);
  }
}
