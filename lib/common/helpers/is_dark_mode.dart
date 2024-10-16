import 'package:flutter/material.dart'; // Importing Flutter material package for UI components.

/// An extension on `BuildContext` to provide additional functionality related to dark mode.
extension DarkMode on BuildContext {

  /// A getter that checks if the current theme is in dark mode.
  ///
  /// Returns `true` if the brightness of the current theme is dark; otherwise, returns `false`.
  bool get isDarkMode {
    return Theme.of(this).brightness == Brightness.dark; // Checks the brightness of the current theme.
  }
}
