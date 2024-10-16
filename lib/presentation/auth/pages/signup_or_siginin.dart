import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify/common/helpers/is_dark_mode.dart';
import 'package:spotify/common/widgets/button/basic_app_button.dart';
import 'package:spotify/core/configs/assets/app_images.dart';
import 'package:spotify/core/configs/assets/app_vectors.dart';
import 'package:spotify/core/configs/theme/app_colors.dart';
import 'package:spotify/presentation/auth/pages/signin.dart';
import 'package:spotify/presentation/auth/pages/signup.dart';

import '../../../common/widgets/appbar/app_bar.dart';

/// A page that allows users to either sign in or register for a new account.
class SignupOrSigninPage extends StatelessWidget {
  const SignupOrSigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Basic app bar displayed at the top of the page.
          const BasicAppbar(),

          // Top pattern SVG image aligned to the top right corner.
          Align(
            alignment: Alignment.topRight,
            child: SvgPicture.asset(
                AppVectors.topPattern
            ),
          ),

          // Bottom pattern SVG image aligned to the bottom right corner.
          Align(
            alignment: Alignment.bottomRight,
            child: SvgPicture.asset(
                AppVectors.bottomPattern
            ),
          ),

          // Background image aligned to the bottom left corner.
          Align(
              alignment: Alignment.bottomLeft,
              child: Image.asset(
                  AppImages.authBG
              )
          ),

          // Center-aligned content of the page.
          Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 40 // Padding around the content.
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center, // Center the content vertically.
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Logo SVG image displayed at the center.
                    SvgPicture.asset(
                        AppVectors.logo
                    ),
                    const SizedBox(
                      height: 55, // Space between logo and text.
                    ),
                    const Text(
                      'Enjoy Listening To Music',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20 // Title text styling.
                      ),
                    ),
                    const SizedBox(
                      height: 21, // Space between title and description.
                    ),
                    const Text(
                      'Spotify is a proprietary Swedish audio streaming and media services provider ',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          color: AppColors.grey // Description text styling.
                      ),
                      textAlign: TextAlign.center, // Center align the description text.
                    ),
                    const SizedBox(
                      height: 30, // Space before buttons.
                    ),

                    // Row containing buttons for registration and sign-in.
                    Row(
                      children: [
                        Expanded(
                          flex: 1, // Take equal space for buttons.
                          child: BasicAppButton(
                              onPressed: () {
                                // Navigate to the SignupPage when the Register button is pressed.
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) => SignupPage()
                                    )
                                );
                              },
                              title: 'Register' // Button title.
                          ),
                        ),
                        const SizedBox(width: 20,), // Space between buttons.
                        Expanded(
                          flex: 1,
                          child: TextButton(
                              onPressed: () {
                                // Navigate to the SigninPage when the Sign in button is pressed.
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) => SigninPage()
                                    )
                                );
                              },
                              child: Text(
                                'Sign in', // Button title.
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    // Change text color based on the current theme (light or dark mode).
                                    color: context.isDarkMode ? Colors.white : Colors.black
                                ),
                              )
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
          ),
        ],
      ),
    );
  }
}
