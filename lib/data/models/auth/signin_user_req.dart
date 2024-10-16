/// A model class representing a request to sign in a user.
///
/// This class is used to encapsulate the data required for user authentication,
/// typically when sending a sign-in request to an API or service.
///
/// It contains the following fields:
/// - [email]: The email address of the user trying to sign in.
/// - [password]: The user's password for authentication.
class SigninUserReq {
  /// The email address of the user.
  final String email;

  /// The password for the user.
  final String password;

  /// Constructor for creating a [SigninUserReq] object.
  ///
  /// Both fields [email] and [password] are required to sign in.
  SigninUserReq({
    required this.email,
    required this.password,
  });
}
