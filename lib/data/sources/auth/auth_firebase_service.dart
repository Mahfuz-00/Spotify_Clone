import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify/core/configs/constants/app_urls.dart';
import 'package:spotify/data/models/auth/create_user_req.dart';
import 'package:spotify/data/models/auth/signin_user_req.dart';
import 'package:spotify/data/models/auth/user.dart';
import 'package:spotify/domain/entities/auth/user.dart';

/// Abstract class defining the contract for authentication services.
/// It outlines the methods that any implementation must provide.
abstract class AuthFirebaseService {
  /// Signs up a new user.
  ///
  /// Accepts a [CreateUserReq] object containing user details.
  /// Returns an [Either] indicating success or failure.
  Future<Either> signup(CreateUserReq createUserReq);

  /// Signs in an existing user.
  ///
  /// Accepts a [SigninUserReq] object containing user credentials.
  /// Returns an [Either] indicating success or failure.
  Future<Either> signin(SigninUserReq signinUserReq);

  /// Retrieves the currently authenticated user.
  ///
  /// Returns an [Either] containing user information or an error message.
  Future<Either> getUser();
}

/// Implementation of the AuthFirebaseService interface using Firebase Authentication and Firestore.
class AuthFirebaseServiceImpl extends AuthFirebaseService {

  /// Signs in a user with the provided credentials.
  ///
  /// Uses [FirebaseAuth] to authenticate the user with email and password.
  ///
  /// Returns:
  /// - [Right]: If signin is successful.
  /// - [Left]: If an error occurs, along with an error message.
  @override
  Future<Either> signin(SigninUserReq signinUserReq) async {
    try {
      // Attempt to sign in the user with email and password using FirebaseAuth
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: signinUserReq.email,
        password: signinUserReq.password,
      );

      // Return a success message wrapped in a Right
      return const Right('Signin was Successful');
    } on FirebaseAuthException catch (e) {
      String message = '';

      // Handle specific error codes from FirebaseAuthException
      if (e.code == 'invalid-email') {
        message = 'No user found for that email';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided for that user';
      }

      // Return the error message wrapped in a Left
      return Left(message);
    }
  }

  /// Signs up a new user with the provided details.
  ///
  /// Uses [FirebaseAuth] to create a new user account and stores user details in Firestore.
  ///
  /// Returns:
  /// - [Right]: If signup is successful.
  /// - [Left]: If an error occurs, along with an error message.
  @override
  Future<Either> signup(CreateUserReq createUserReq) async {
    try {
      // Attempt to create a new user account in FirebaseAuth
      var data = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: createUserReq.email,
        password: createUserReq.password,
      );

      // Store additional user details in Firestore
      await FirebaseFirestore.instance.collection('Users').doc(data.user?.uid).set({
        'name': createUserReq.fullName,
        'email': data.user?.email,
      });

      // Return a success message wrapped in a Right
      return const Right('Signup was Successful');
    } on FirebaseAuthException catch (e) {
      String message = '';

      // Handle specific error codes from FirebaseAuthException
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak';
      } else if (e.code == 'email-already-in-use') {
        message = 'An account already exists with that email.';
      }

      // Return the error message wrapped in a Left
      return Left(message);
    }
  }

  /// Retrieves the currently authenticated user's details.
  ///
  /// If the user is authenticated, it fetches their data from Firestore and converts it to a [UserEntity].
  ///
  /// Returns:
  /// - [Right]: A [UserEntity] containing user details.
  /// - [Left]: An error message if retrieval fails.
  @override
  Future<Either> getUser() async {
    try {
      // Initialize FirebaseAuth and Firestore instances
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      // Fetch the current user's data from Firestore
      var user = await firebaseFirestore.collection('Users').doc(firebaseAuth.currentUser?.uid).get();

      // Convert the Firestore data to a UserModel
      UserModel userModel = UserModel.fromJson(user.data()!);

      // Add the user's profile image URL, defaulting to a placeholder if none exists
      userModel.imageURL = firebaseAuth.currentUser?.photoURL ?? AppURLs.defaultImage;

      // Convert UserModel to UserEntity for use in the application
      UserEntity userEntity = userModel.toEntity();

      // Return the UserEntity wrapped in a Right
      return Right(userEntity);
    } catch (e) {
      // Return a generic error message wrapped in a Left if an error occurs
      return const Left('An error occurred');
    }
  }
}
