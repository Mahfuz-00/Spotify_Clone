import 'package:flutter/material.dart'; // Importing Flutter material package for UI components.
import 'package:spotify/common/helpers/is_dark_mode.dart'; // Importing the dark mode helper extension.

/// A customizable app bar widget that implements `PreferredSizeWidget`.
///
/// This widget allows for a title, an action button, and customizable background color,
/// and can optionally hide the back button.
class BasicAppbar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title; // The title of the app bar, can be a Widget.
  final Widget? action; // An optional action widget (e.g., an icon button).
  final Color? backgroundColor; // The background color of the app bar.
  final bool hideBack; // A flag to determine if the back button should be hidden.

  /// Constructor for `BasicAppbar`, allowing optional parameters for title, action,
  /// background color, and back button visibility.
  const BasicAppbar({
    this.title,
    this.hideBack = false,
    this.action,
    this.backgroundColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Building the AppBar widget.
    return AppBar(
      backgroundColor: backgroundColor ?? Colors.transparent, // Uses provided background color or defaults to transparent.
      elevation: 0, // Removes shadow below the AppBar.
      centerTitle: true, // Centers the title in the AppBar.
      title: title ?? const Text(''), // Displays the provided title or an empty Text widget if none is provided.
      actions: [
        action ?? Container() // Displays the action widget or an empty container if none is provided.
      ],
      leading: hideBack // Conditionally renders the back button based on the hideBack flag.
          ? null
          : IconButton(
        onPressed: () {
          Navigator.pop(context); // Pops the current route off the navigator stack.
        },
        icon: Container(
          height: 50, // Sets height of the back button container.
          width: 50, // Sets width of the back button container.
          decoration: BoxDecoration(
            color: context.isDarkMode // Uses the dark mode helper to determine background color.
                ? Colors.white.withOpacity(0.03) // Light background for dark mode.
                : Colors.black.withOpacity(0.04), // Dark background for light mode.
            shape: BoxShape.circle, // Makes the container circular.
          ),
          child: Icon(
            Icons.arrow_back_ios_new, // The icon for the back button.
            size: 15, // Sets the size of the icon.
            color: context.isDarkMode // Sets icon color based on dark mode.
                ? Colors.white // White icon in dark mode.
                : Colors.black, // Black icon in light mode.
          ),
        ),
      ),
    );
  }

  /// Returns the preferred size of the AppBar, setting it to the default toolbar height.
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
