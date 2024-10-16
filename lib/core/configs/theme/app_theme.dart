import 'package:flutter/material.dart';

import 'app_colors.dart';

/// A utility class that defines the light and dark themes used in the app.
///
/// This class centralizes theme configuration, making it easy to manage 
/// the appearance of the app in both light and dark modes. It includes 
/// settings for primary colors, background colors, text styles, buttons, 
/// sliders, and input decorations.
class AppTheme {

  /// The theme configuration for light mode.
  ///
  /// - Sets the primary color to [AppColors.primary].
  /// - Uses [AppColors.lightBackground] as the scaffold background color.
  /// - Configures the input fields, buttons, and sliders to match the light mode appearance.
  static final lightTheme = ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.lightBackground,
    brightness: Brightness.light,
    fontFamily: 'Satoshi', // Custom font used throughout the app
    sliderTheme: SliderThemeData(
        overlayShape: SliderComponentShape.noOverlay
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.transparent,
      contentPadding: const EdgeInsets.all(30),
      hintStyle: const TextStyle(
        color: Color(0xff383838), // Hint text color
        fontWeight: FontWeight.w500,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(
            color: Colors.white,
            width: 0.4
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(
            color: Colors.black,
            width: 0.4
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          elevation: 0,
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30)
          )
      ),
    ),
  );

  /// The theme configuration for dark mode.
  ///
  /// - Sets the primary color to [AppColors.primary].
  /// - Uses [AppColors.darkBackground] as the scaffold background color.
  /// - Configures the input fields, buttons, and sliders to match the dark mode appearance.
  static final darkTheme = ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.darkBackground,
    brightness: Brightness.dark,
    fontFamily: 'Satoshi', // Custom font used throughout the app
    sliderTheme: SliderThemeData(
        overlayShape: SliderComponentShape.noOverlay,
        activeTrackColor: Color(0xffB7B7B7), // Active track color for sliders
        inactiveTrackColor: Colors.grey.withOpacity(0.3), // Inactive track color
        thumbColor: Color(0xffB7B7B7) // Thumb color for sliders
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.transparent,
      hintStyle: const TextStyle(
        color: Color(0xffA7A7A7), // Hint text color for dark mode
        fontWeight: FontWeight.w500,
      ),
      contentPadding: const EdgeInsets.all(30),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(
            color: Colors.white,
            width: 0.4
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(
            color: Colors.white,
            width: 0.4
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        elevation: 0,
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30)
        ),
      ),
    ),
  );
}
