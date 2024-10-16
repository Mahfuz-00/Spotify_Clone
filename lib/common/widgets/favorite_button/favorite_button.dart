import 'package:flutter/material.dart'; // Importing Flutter material package for UI components.
import 'package:flutter_bloc/flutter_bloc.dart'; // Importing Flutter Bloc for state management.
import 'package:spotify/common/bloc/favorite_button/favorite_button_cubit.dart'; // Importing the Cubit for managing favorite button state.
import 'package:spotify/domain/entities/song/song.dart'; // Importing the SongEntity model.

import '../../../core/configs/theme/app_colors.dart'; // Importing custom app colors for theme.
import '../../bloc/favorite_button/favorite_button_state.dart'; // Importing favorite button states.

/// A widget that manages and displays the favorite button for a song.
///
/// This widget uses a `BlocProvider` to manage the state of the favorite button, allowing the user to
/// add or remove a song from their favorites. The button changes its icon depending on whether the
/// song is marked as a favorite or not.
class FavoriteButton extends StatelessWidget {
  final SongEntity songEntity; // The song entity object containing song details, including the favorite status.
  final Function? function; // An optional callback function to be executed after the button is pressed.

  /// Constructor for `FavoriteButton`, requiring a `songEntity` and optionally accepting a `function` callback.
  const FavoriteButton({
    required this.songEntity,
    this.function,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Providing the `FavoriteButtonCubit` to manage state for the favorite button.
    return BlocProvider(
      create: (context) => FavoriteButtonCubit(),
      child: BlocBuilder<FavoriteButtonCubit, FavoriteButtonState>(
        builder: (context, state) {
          // If the button is in its initial state (before any interaction).
          if (state is FavoriteButtonInitial) {
            return IconButton(
              onPressed: () async {
                // Calls the Cubit method to update the favorite status of the song.
                await context.read<FavoriteButtonCubit>().favoriteButtonUpdated(
                  songEntity.songId,
                );
                // Executes the optional callback function if provided.
                if (function != null) {
                  function!();
                }
              },
              // Displays the favorite icon based on whether the song is a favorite.
              icon: Icon(
                songEntity.isFavorite
                    ? Icons.favorite // Filled heart icon for favorite songs.
                    : Icons.favorite_outline_outlined, // Outline heart icon for non-favorite songs.
                size: 25, // Sets the size of the icon.
                color: AppColors.darkGrey, // Applies a custom color from the app's theme.
              ),
            );
          }

          // If the button state has been updated (after interaction).
          if (state is FavoriteButtonUpdated) {
            return IconButton(
              onPressed: () {
                // Calls the Cubit method to toggle the favorite status.
                context.read<FavoriteButtonCubit>().favoriteButtonUpdated(
                  songEntity.songId,
                );
              },
              // Displays the updated favorite icon based on the current favorite status.
              icon: Icon(
                state.isFavorite
                    ? Icons.favorite // Filled heart icon for favorite.
                    : Icons.favorite_outline_outlined, // Outline heart icon for non-favorite.
                size: 25, // Sets the size of the icon.
                color: AppColors.darkGrey, // Applies a custom color from the app's theme.
              ),
            );
          }

          // Returns an empty container if no state is available.
          return Container();
        },
      ),
    );
  }
}
