import 'package:spotify/domain/entities/auth/user.dart';

/// Abstract class representing the various states of the profile information.
abstract class ProfileInfoState {}

/// State indicating that the profile information is currently being loaded.
class ProfileInfoLoading extends ProfileInfoState {}

/// State representing successfully loaded profile information.
/// Contains the [userEntity] that holds the user's details.
class ProfileInfoLoaded extends ProfileInfoState {
  final UserEntity userEntity; // The user entity containing profile information.

  /// Constructor that requires a [UserEntity] to be passed in.
  ProfileInfoLoaded({required this.userEntity});
}

/// State indicating a failure to load profile information.
class ProfileInfoFailure extends ProfileInfoState {}
