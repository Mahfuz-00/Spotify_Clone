import 'package:dartz/dartz.dart';
import 'package:spotify/data/models/auth/create_user_req.dart';
import 'package:spotify/data/models/auth/signin_user_req.dart';
import 'package:spotify/data/sources/auth/auth_firebase_service.dart';
import 'package:spotify/domain/repository/auth/auth.dart';
import '../../../service_locator.dart';

/// Implementation of the [AuthRepository] interface.
///
/// This class provides the concrete implementation for authentication
/// functionalities, utilizing the [AuthFirebaseService] to perform
/// actual authentication operations with Firebase.
///
/// It includes methods for user sign-in, sign-up, and fetching user data.
class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<Either> signin(SigninUserReq signinUserReq) async {
    // Calls the signin method of AuthFirebaseService with the provided request.
    return await sl<AuthFirebaseService>().signin(signinUserReq);
  }

  @override
  Future<Either> signup(CreateUserReq createUserReq) async {
    // Calls the signup method of AuthFirebaseService with the provided request.
    return await sl<AuthFirebaseService>().signup(createUserReq);
  }

  @override
  Future<Either> getUser() async {
    // Calls the getUser method of AuthFirebaseService to fetch user data.
    return await sl<AuthFirebaseService>().getUser();
  }
}
