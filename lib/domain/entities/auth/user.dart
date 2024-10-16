/// A class representing a user entity.
///
/// This class contains user-related information such as:
/// - [fullName]: The full name of the user.
/// - [email]: The email address of the user.
/// - [imageURL]: The URL of the user's profile image.
class UserEntity {

  String? fullName; // The full name of the user
  String? email;    // The email address of the user
  String? imageURL; // The URL of the user's profile image

  UserEntity({
    this.fullName,
    this.email,
    this.imageURL,
  });
}
