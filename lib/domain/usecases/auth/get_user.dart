import 'package:dartz/dartz.dart';
import 'package:spotify/core/usecase/usecase.dart';
import 'package:spotify/domain/repository/auth/auth.dart';

import '../../../service_locator.dart';

/// A use case for retrieving user information.
///
/// This class implements the [UseCase] interface and interacts
/// with the [AuthRepository] to get the current user's details.
class GetUserUseCase implements UseCase<Either, dynamic> {

  /// Calls the [AuthRepository] to retrieve the user information.
  ///
  /// Returns an [Either] representing the success or failure of the operation.
  @override
  Future<Either> call({params}) async {
    return await sl<AuthRepository>().getUser();
  }
}
