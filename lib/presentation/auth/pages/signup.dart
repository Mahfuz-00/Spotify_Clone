import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify/common/widgets/appbar/app_bar.dart';
import 'package:spotify/common/widgets/button/basic_app_button.dart';
import 'package:spotify/core/configs/assets/app_vectors.dart';
import 'package:spotify/data/models/auth/create_user_req.dart';
import 'package:spotify/domain/usecases/auth/signup.dart';
import 'package:spotify/presentation/auth/pages/signin.dart';
import 'package:spotify/presentation/home/pages/home.dart';
import 'package:spotify/service_locator.dart';

/// A stateless widget representing the Signup page of the application.
class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  // Text editing controllers for capturing user input.
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Bottom navigation bar with a sign-in text link.
      bottomNavigationBar: _siginText(context),
      appBar: BasicAppbar(
        title: SvgPicture.asset(
          AppVectors.logo, // Display the app logo.
          height: 40,
          width: 40,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          vertical: 50,
          horizontal: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _registerText(), // Header text for the registration page.
            const SizedBox(height: 50),
            _fullNameField(context), // Text field for full name input.
            const SizedBox(height: 20),
            _emailField(context), // Text field for email input.
            const SizedBox(height: 20),
            _passwordField(context), // Text field for password input.
            const SizedBox(height: 20),
            BasicAppButton(
              onPressed: () async {
                // Execute signup use case when button is pressed.
                var result = await sl<SignupUseCase>().call(
                  params: CreateUserReq(
                    fullName: _fullName.text.toString(),
                    email: _email.text.toString(),
                    password: _password.text.toString(),
                  ),
                );
                // Handle the result of the signup process.
                result.fold(
                      (l) {
                    // Show an error message if signup fails.
                    var snackbar = SnackBar(
                      content: Text(l),
                      behavior: SnackBarBehavior.floating,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackbar);
                  },
                      (r) {
                    // Navigate to the home page on successful signup.
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (BuildContext context) => const HomePage()),
                          (route) => false,
                    );
                  },
                );
              },
              title: 'Create Account', // Button label.
            )
          ],
        ),
      ),
    );
  }

  /// Widget to display the title text for the registration page.
  Widget _registerText() {
    return const Text(
      'Register',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 25,
      ),
      textAlign: TextAlign.center,
    );
  }

  /// Widget for the full name input field.
  Widget _fullNameField(BuildContext context) {
    return TextField(
      controller: _fullName,
      decoration: const InputDecoration(
        hintText: 'Full Name', // Hint text for the field.
      ).applyDefaults(
        Theme.of(context).inputDecorationTheme, // Apply theme.
      ),
    );
  }

  /// Widget for the email input field.
  Widget _emailField(BuildContext context) {
    return TextField(
      controller: _email,
      decoration: const InputDecoration(
        hintText: 'Enter Email', // Hint text for the field.
      ).applyDefaults(
        Theme.of(context).inputDecorationTheme, // Apply theme.
      ),
    );
  }

  /// Widget for the password input field.
  Widget _passwordField(BuildContext context) {
    return TextField(
      controller: _password,
      decoration: const InputDecoration(
        hintText: 'Password', // Hint text for the field.
      ).applyDefaults(
        Theme.of(context).inputDecorationTheme, // Apply theme.
      ),
    );
  }

  /// Widget to display a text link to the sign-in page.
  Widget _siginText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 30,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Do you have an account? ',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          TextButton(
            onPressed: () {
              // Navigate to the SigninPage when the button is pressed.
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => SigninPage(),
                ),
              );
            },
            child: const Text(
              'Sign In', // Text for the button.
            ),
          ),
        ],
      ),
    );
  }
}
