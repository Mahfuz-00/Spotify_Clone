import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/common/helpers/is_dark_mode.dart';
import 'package:spotify/core/configs/constants/app_urls.dart';
import 'package:spotify/core/configs/theme/app_colors.dart';
import 'package:spotify/presentation/home/bloc/news_songs_cubit.dart';
import 'package:spotify/presentation/song_player/pages/song_player.dart';

import '../../../domain/entities/song/song.dart';
import '../bloc/news_songs_state.dart';

/// A StatelessWidget that displays a horizontal list of news songs.
class NewsSongs extends StatelessWidget {
  const NewsSongs({super.key});

  @override
  Widget build(BuildContext context) {
    // Provides the NewsSongsCubit to manage state for the NewsSongs widget
    return BlocProvider(
      create: (_) => NewsSongsCubit()..getNewsSongs(), // Initialize and call getNewsSongs
      child: SizedBox(
          height: 200, // Set a fixed height for the NewsSongs widget
          child: BlocBuilder<NewsSongsCubit, NewsSongsState>(
            builder: (context, state) {
              // Handle the different states of the NewsSongsCubit
              if (state is NewsSongsLoading) {
                // If the state is loading, show a CircularProgressIndicator
                return Container(
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(),
                );
              }

              if (state is NewsSongsLoaded) {
                // If the state is loaded, display the list of songs
                return _songs(state.songs);
              }

              // Return an empty container if the state is neither loading nor loaded
              return Container();
            },
          )
      ),
    );
  }

  /// Builds a horizontal list of songs.
  ///
  /// Takes a list of [SongEntity] and returns a ListView.
  Widget _songs(List<SongEntity> songs) {
    return ListView.separated(
        scrollDirection: Axis.horizontal, // Allow horizontal scrolling
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
            child: SizedBox(
              width: 160, // Set a fixed width for each song item
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30), // Round the corners of the container
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                // Construct the URL for the song cover image
                                  '${AppURLs.coverFirestorage}${songs[index].artist} - ${songs[index].title}.jpg?${AppURLs.mediaAlt}'
                              )
                          )
                      ),
                      child: Align(
                        alignment: Alignment.bottomRight, // Align play button to the bottom right
                        child: Container(
                          height: 40,
                          width: 40,
                          transform: Matrix4.translationValues(10, 10, 0), // Offset the play button
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, // Make the button circular
                              color: context.isDarkMode ? AppColors.darkGrey : const Color(0xffE6E6E6) // Set color based on theme
                          ),
                          child: Icon(
                            Icons.play_arrow_rounded,
                            color: context.isDarkMode ? const Color(0xff959595) : const Color(0xff555555), // Icon color based on theme
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,), // Space between image and title
                  Text(
                    songs[index].title, // Display song title
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16
                    ),
                  ),
                  const SizedBox(height: 5,), // Space between title and artist name
                  Text(
                    songs[index].artist, // Display artist name
                    style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12
                    ),
                  )
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 14,), // Space between items in the list
        itemCount: songs.length // Number of items in the list
    );
  }
}
