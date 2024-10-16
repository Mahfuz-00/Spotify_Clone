/// A model class representing a request to create a new user.
///
/// This class encapsulates the data required for creating a new user in the
/// application, typically used when sending data to an API or service.
///
/// It contains the following fields:
/// - [fullName]: The full name of the user being created.
/// - [email]: The email address of the user.
/// - [password]: The password that the user will use to log in.
class CreateUserReq {
  /// The full name of the user.
  final String fullName;

  /// The email address of the user.
  final String email;

  /// The password for the user.
  final String password;

  /// Constructor for creating a [CreateUserReq] object.
  ///
  /// All fields are required and must be passed when creating a new instance.
  CreateUserReq({
    required this.fullName,
    required this.email,
    required this.password,
  });
}
