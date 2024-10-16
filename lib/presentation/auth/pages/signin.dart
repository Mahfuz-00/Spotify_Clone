import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify/common/widgets/appbar/app_bar.dart';
import 'package:spotify/common/widgets/button/basic_app_button.dart';
import 'package:spotify/core/configs/assets/app_vectors.dart';
import 'package:spotify/data/models/auth/signin_user_req.dart';
import 'package:spotify/presentation/auth/pages/signup.dart';

import '../../../domain/usecases/auth/sigin.dart';
import '../../../service_locator.dart';
import '../../home/pages/home.dart';

/// A page for user sign-in, allowing users to enter their email and password
/// to access their account.
///
/// The SigninPage includes input fields for email and password, a sign-in
/// button, and a link to the registration page for new users.
class SigninPage extends StatelessWidget {
  SigninPage({super.key});

  final TextEditingController _email = TextEditingController();  // Controller for the email input field.
  final TextEditingController _password = TextEditingController();  // Controller for the password input field.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _signupText(context),  // Displays a link to the signup page.
      appBar: BasicAppbar(  // Custom app bar with the app logo.
        title: SvgPicture.asset(
          AppVectors.logo,
          height: 40,
          width: 40,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
            vertical: 50,
            horizontal: 30
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _registerText(),  // Displays the sign-in text.
            const SizedBox(height: 50,),
            _emailField(context),  // Email input field.
            const SizedBox(height: 20,),
            _passwordField(context),  // Password input field.
            const SizedBox(height: 20,),
            BasicAppButton(
                onPressed: () async {
                  // Executes the sign-in process when the button is pressed.
                  var result = await sl<SigninUseCase>().call(
                      params: SigninUserReq(
                          email: _email.text.toString(),  // Gets email input.
                          password: _password.text.toString()  // Gets password input.
                      )
                  );

                  // Handles the result of the sign-in attempt.
                  result.fold(
                          (l) {
                        // Displays a snackbar with an error message if sign-in fails.
                        var snackbar = SnackBar(content: Text(l), behavior: SnackBarBehavior.floating);
                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      },
                          (r) {
                        // Navigates to the HomePage on successful sign-in.
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (BuildContext context) => const HomePage()),
                                (route) => false
                        );
                      }
                  );
                },
                title: 'Sign In'  // Button label.
            )
          ],
        ),
      ),
    );
  }

  /// Creates a text widget that displays the title "Sign In".
  Widget _registerText() {
    return const Text(
      'Sign In',
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25
      ),
      textAlign: TextAlign.center,
    );
  }

  /// Creates a text field for the user to enter their email.
  Widget _emailField(BuildContext context) {
    return TextField(
      controller: _email,  // Binds the controller to the text field.
      decoration: const InputDecoration(
          hintText: 'Enter Email'  // Placeholder text.
      ).applyDefaults(
          Theme.of(context).inputDecorationTheme  // Applies default input decoration theme.
      ),
    );
  }

  /// Creates a text field for the user to enter their password.
  Widget _passwordField(BuildContext context) {
    return TextField(
      controller: _password,  // Binds the controller to the text field.
      decoration: const InputDecoration(
          hintText: 'Password'  // Placeholder text.
      ).applyDefaults(
          Theme.of(context).inputDecorationTheme  // Applies default input decoration theme.
      ),
      obscureText: true,  // Hides password input for security.
    );
  }

  /// Creates a row with a message and a button that redirects to the signup page.
  Widget _signupText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: 30
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Not A Member? ',
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14
            ),
          ),
          TextButton(
              onPressed: () {
                // Navigates to the SignupPage when the button is pressed.
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => SignupPage()
                    )
                );
              },
              child: const Text(
                  'Register Now'  // Button label.
              )
          )
        ],
      ),
    );
  }
}
