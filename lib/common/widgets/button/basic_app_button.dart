import 'package:flutter/material.dart'; // Importing Flutter material package for UI components.

/// A customizable button widget that uses `ElevatedButton` for its UI.
///
/// The button requires an `onPressed` callback and a `title` for the text on the button.
/// Optionally, a `height` can be provided for the button's size.
class BasicAppButton extends StatelessWidget {
  final VoidCallback onPressed; // A callback function triggered when the button is pressed.
  final String title; // The text displayed on the button.
  final double? height; // Optional height for the button; defaults to 80 if not provided.

  /// Constructor for `BasicAppButton`, requiring `onPressed` and `title` parameters.
  /// An optional `height` can be passed to customize the button size.
  const BasicAppButton({
    required this.onPressed,
    required this.title,
    this.height,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Building an `ElevatedButton` with the given properties.
    return ElevatedButton(
      onPressed: onPressed, // Assigns the provided onPressed callback.
      style: ElevatedButton.styleFrom(
        // Sets the minimum height of the button; defaults to 80 if height is not specified.
        minimumSize: Size.fromHeight(height ?? 80),
      ),
      child: Text(
        title, // Displays the provided title text inside the button.
      ),
    );
  }
}
