import 'package:dartz/dartz.dart';

import '../../../data/models/auth/create_user_req.dart';
import '../../../data/models/auth/signin_user_req.dart';

/// An abstract class representing the authentication repository.
///
/// This repository provides methods for user authentication,
/// including signing up, signing in, and fetching user information.
///
/// Methods:
/// - [signup]: Signs up a new user using the provided [CreateUserReq].
/// - [signin]: Signs in an existing user using the provided [SigninUserReq].
/// - [getUser]: Retrieves the current authenticated user's information.
abstract class AuthRepository {

  /// Signs up a new user.
  ///
  /// Takes a [CreateUserReq] object containing the user's details.
  /// Returns an [Either] representing the success or failure of the operation.
  Future<Either> signup(CreateUserReq createUserReq);

  /// Signs in an existing user.
  ///
  /// Takes a [SigninUserReq] object containing the user's credentials.
  /// Returns an [Either] representing the success or failure of the operation.
  Future<Either> signin(SigninUserReq signinUserReq);

  /// Retrieves the current authenticated user's information.
  ///
  /// Returns an [Either] representing the success or failure of the operation.
  Future<Either> getUser();
}
