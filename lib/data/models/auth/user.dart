import 'package:spotify/domain/entities/auth/user.dart';

/// A model class representing a user.
///
/// This class is used to create a user object from JSON data
/// and provides a method to convert it to a domain entity.
///
/// It contains the following optional fields:
/// - [fullName]: The full name of the user.
/// - [email]: The email address of the user.
/// - [imageURL]: The URL of the user's profile image.
class UserModel {
  String? fullName;
  String? email;
  String? imageURL;

  /// Constructor for creating a [UserModel] object.
  ///
  /// All fields are optional and can be null.
  UserModel({
    this.fullName,
    this.email,
    this.imageURL,
  });

  /// Factory constructor for creating a [UserModel] from a JSON map.
  ///
  /// This constructor extracts the [name] and [email] fields from the JSON map.
  UserModel.fromJson(Map<String, dynamic> data) {
    fullName = data['name'];
    email = data['email'];
  }
}

/// Extension on [UserModel] to convert it to a [UserEntity].
extension UserModelX on UserModel {
  /// Converts the [UserModel] instance to a [UserEntity].
  ///
  /// This method is useful for transforming the model to a
  /// domain layer representation of the user.
  UserEntity toEntity() {
    return UserEntity(
      email: email,
      fullName: fullName,
      imageURL: imageURL,
    );
  }
}
