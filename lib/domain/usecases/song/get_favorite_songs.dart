import 'package:dartz/dartz.dart';
import 'package:spotify/core/usecase/usecase.dart';

import '../../../service_locator.dart';
import '../../repository/song/song.dart';

/// A use case for retrieving the user's favorite songs.
///
/// This class implements the [UseCase] interface and interacts
/// with the [SongsRepository] to fetch a list of songs marked as favorites by the user.
class GetFavoriteSongsUseCase implements UseCase<Either, dynamic> {

  /// Calls the [SongsRepository] to retrieve the user's favorite songs.
  ///
  /// Returns an [Either] representing the success or failure of the operation,
  /// which may include a list of favorite songs or an error message.
  @override
  Future<Either> call({params}) async {
    return await sl<SongsRepository>().getUserFavoriteSongs();
  }
}
