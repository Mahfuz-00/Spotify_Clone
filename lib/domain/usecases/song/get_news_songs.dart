import 'package:dartz/dartz.dart';
import 'package:spotify/core/usecase/usecase.dart';

import '../../../service_locator.dart';
import '../../repository/song/song.dart';

/// A use case for retrieving the latest songs.
///
/// This class implements the [UseCase] interface and interacts
/// with the [SongsRepository] to fetch a list of new songs.
class GetNewsSongsUseCase implements UseCase<Either, dynamic> {

  /// Calls the [SongsRepository] to retrieve the latest songs.
  ///
  /// Returns an [Either] representing the success or failure of the operation,
  /// which may include a list of new songs or an error message.
  @override
  Future<Either> call({params}) async {
    return await sl<SongsRepository>().getNewsSongs();
  }
}
