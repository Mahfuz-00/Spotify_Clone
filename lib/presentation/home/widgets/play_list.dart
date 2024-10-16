import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/common/helpers/is_dark_mode.dart';
import 'package:spotify/core/configs/theme/app_colors.dart';
import 'package:spotify/presentation/home/bloc/play_list_cubit.dart';

import '../../../common/widgets/favorite_button/favorite_button.dart';
import '../../../domain/entities/song/song.dart';
import '../../song_player/pages/song_player.dart';
import '../bloc/play_list_state.dart';

/// A StatelessWidget that displays a playlist of songs.
class PlayList extends StatelessWidget {
  const PlayList({super.key});

  @override
  Widget build(BuildContext context) {
    // Provides the PlayListCubit to manage the state for the PlayList widget
    return BlocProvider(
      create: (_) => PlayListCubit()..getPlayList(), // Initialize and fetch the playlist
      child: BlocBuilder<PlayListCubit, PlayListState>(
        builder: (context, state) {
          // Handle the different states of the PlayListCubit
          if (state is PlayListLoading) {
            // If the state is loading, show a CircularProgressIndicator
            return Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            );
          }
          if (state is PlayListLoaded) {
            // If the state is loaded, display the playlist
            return Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 40,
                horizontal: 16,
              ),
              child: Column(
                children: [
                  // Playlist header with title and "See More" option
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Playlist',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'See More',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: Color(0xffC6C6C6), // Grey color for "See More"
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20,), // Space between header and song list
                  _songs(state.songs), // Call the _songs method to build the song list
                ],
              ),
            );
          }

          // Return an empty container if the state is neither loading nor loaded
          return Container();
        },
      ),
    );
  }

  /// Builds a ListView of songs.
  ///
  /// Takes a list of [SongEntity] and returns a ListView.
  Widget _songs(List<SongEntity> songs) {
    return ListView.separated(
      shrinkWrap: true, // Prevents unnecessary space in the ListView
      itemBuilder: (context, index) {
        // Build each song item in the list
        return GestureDetector(
          onTap: () {
            // Navigate to the SongPlayerPage when a song is tapped
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => SongPlayerPage(
                  songEntity: songs[index], // Pass the selected song entity
                ),
              ),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  // Play button styled as a circular icon
                  Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle, // Make the button circular
                      color: context.isDarkMode ? AppColors.darkGrey : const Color(0xffE6E6E6), // Set color based on theme
                    ),
                    child: Icon(
                      Icons.play_arrow_rounded,
                      color: context.isDarkMode ? const Color(0xff959595) : const Color(0xff555555), // Icon color based on theme
                    ),
                  ),
                  const SizedBox(width: 10,), // Space between play button and song details
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        songs[index].title, // Display song title
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 5,), // Space between title and artist name
                      Text(
                        songs[index].artist, // Display artist name
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  // Display the duration of the song
                  Text(
                    songs[index].duration.toString().replaceAll('.', ':'), // Format duration to a readable format
                  ),
                  const SizedBox(width: 20,), // Space between duration and favorite button
                  FavoriteButton(
                    songEntity: songs[index], // Pass the current song entity to the FavoriteButton
                  ),
                ],
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 20,), // Space between items in the list
      itemCount: songs.length, // Number of items in the list
    );
  }
}
