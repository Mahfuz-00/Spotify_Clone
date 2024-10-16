import 'package:dartz/dartz.dart';
import 'package:spotify/core/usecase/usecase.dart';
import 'package:spotify/data/models/auth/create_user_req.dart';
import 'package:spotify/domain/repository/auth/auth.dart';

import '../../../service_locator.dart';

/// A use case for signing up a new user.
///
/// This class implements the [UseCase] interface and interacts
/// with the [AuthRepository] to handle user sign-up requests.
class SignupUseCase implements UseCase<Either, CreateUserReq> {

  /// Calls the [AuthRepository] to sign up a new user with the provided [CreateUserReq].
  ///
  /// [params] must not be null and should contain the required information for registration.
  /// Returns an [Either] representing the success or failure of the operation.
  @override
  Future<Either> call({CreateUserReq? params}) async {
    return sl<AuthRepository>().signup(params!);
  }
}
