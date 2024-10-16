import 'package:dartz/dartz.dart';
import 'package:spotify/core/usecase/usecase.dart';

import '../../../service_locator.dart';
import '../../repository/song/song.dart';

/// A use case for retrieving the user's playlist.
///
/// This class implements the [UseCase] interface and interacts
/// with the [SongsRepository] to fetch a list of songs in the user's playlist.
class GetPlayListUseCase implements UseCase<Either, dynamic> {

  /// Calls the [SongsRepository] to retrieve the playlist.
  ///
  /// Returns an [Either] representing the success or failure of the operation,
  /// which may include a list of songs in the user's playlist or an error message.
  @override
  Future<Either> call({params}) async {
    return await sl<SongsRepository>().getPlayList();
  }
}
