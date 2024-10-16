import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify/core/configs/assets/app_vectors.dart';
import 'package:spotify/presentation/intro/pages/get_started.dart';

/// A splash screen that displays the app's logo while transitioning to the
/// Get Started page after a brief delay.
///
/// This page is displayed when the app is launched, providing an initial
/// loading experience before navigating to the main content.
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    redirect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SvgPicture.asset(
          AppVectors.logo,  // Displays the app logo as an SVG image.
        ),
      ),
    );
  }

  /// Redirects the user to the Get Started page after a 2-second delay.
  ///
  /// This method uses a [Future.delayed] to wait for 2 seconds
  /// before navigating to the GetStartedPage. It ensures that the
  /// splash screen is visible for a brief period before the user
  /// is taken to the next screen.
  Future<void> redirect() async {
    await Future.delayed(const Duration(seconds: 2));  // Wait for 2 seconds.
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => const GetStartedPage(),
      ),
    );
  }
}
