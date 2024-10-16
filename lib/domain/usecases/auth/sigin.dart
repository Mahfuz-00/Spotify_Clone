import 'package:dartz/dartz.dart';
import 'package:spotify/core/usecase/usecase.dart';
import 'package:spotify/data/models/auth/signin_user_req.dart';
import 'package:spotify/domain/repository/auth/auth.dart';

import '../../../service_locator.dart';

/// A use case for signing in a user.
///
/// This class implements the [UseCase] interface and interacts
/// with the [AuthRepository] to handle user sign-in requests.
class SigninUseCase implements UseCase<Either, SigninUserReq> {

  /// Calls the [AuthRepository] to sign in the user with the provided [SigninUserReq].
  ///
  /// [params] must not be null and should contain the sign-in credentials.
  /// Returns an [Either] representing the success or failure of the operation.
  @override
  Future<Either> call({SigninUserReq? params}) async {
    return sl<AuthRepository>().signin(params!);
  }
}
