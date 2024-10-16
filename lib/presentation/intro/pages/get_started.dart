import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify/common/widgets/button/basic_app_button.dart';
import 'package:spotify/core/configs/assets/app_images.dart';
import 'package:spotify/core/configs/assets/app_vectors.dart';
import 'package:spotify/core/configs/theme/app_colors.dart';
import 'package:spotify/presentation/choose_mode/pages/choose_mode.dart';

/// A page that introduces the app and allows users to get started.
class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image container
          Container(
            padding: const EdgeInsets.symmetric(
                vertical: 40,
                horizontal: 40
            ),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(
                      AppImages.introBG, // Background image for the intro
                    )
                )
            ),
          ),

          // Dimmed overlay for better text visibility
          Container(
            color: Colors.black.withOpacity(0.15),
          ),

          // Main content container
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 40,
                horizontal: 40
            ),
            child: Column(
              children: [
                // Logo at the top center
                Align(
                  alignment: Alignment.topCenter,
                  child: SvgPicture.asset(
                      AppVectors.logo // App logo
                  ),
                ),
                const Spacer(), // Spacer to push content to the bottom
                const Text(
                  'Enjoy Listening To Music', // Main headline
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18
                  ),
                ),
                const SizedBox(height: 21,),
                const Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppColors.grey, // Subtext color
                      fontSize: 13
                  ),
                  textAlign: TextAlign.center, // Center the subtext
                ),
                const SizedBox(height: 20,),
                // Get Started button
                BasicAppButton(
                    onPressed: () {
                      // Navigate to ChooseModePage on button press
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => const ChooseModePage()
                          )
                      );
                    },
                    title: 'Get Started' // Button title
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
