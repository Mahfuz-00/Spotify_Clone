import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/common/widgets/appbar/app_bar.dart';
import 'package:spotify/domain/entities/song/song.dart';
import 'package:spotify/presentation/song_player/bloc/song_player_cubit.dart';
import 'package:spotify/presentation/song_player/bloc/song_player_state.dart';

import '../../../common/widgets/favorite_button/favorite_button.dart';
import '../../../core/configs/constants/app_urls.dart';
import '../../../core/configs/theme/app_colors.dart';

// A StatelessWidget that represents the Song Player page,
// displaying details of the currently playing song and controls for playback.
class SongPlayerPage extends StatelessWidget {
  final SongEntity songEntity; // The SongEntity object representing the song to be played.

  const SongPlayerPage({
    required this.songEntity, // Required constructor parameter for the song entity.
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbar(
        title: const Text(
          'Now playing',
          style: TextStyle(fontSize: 18),
        ),
        action: IconButton(
          onPressed: () {}, // Placeholder for a future action button.
          icon: const Icon(Icons.more_vert_rounded),
        ),
      ),
      body: BlocProvider(
        create: (_) => SongPlayerCubit()..loadSong(
          // Load the song using the URL constructed from the song entity's properties.
            '${AppURLs.songFirestorage}${songEntity.artist} - ${songEntity.title}.mp3?${AppURLs.mediaAlt}'
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Builder(
            builder: (context) {
              return Column(
                children: [
                  _songCover(context), // Display the song cover image.
                  const SizedBox(height: 20),
                  _songDetail(), // Display the song details.
                  const SizedBox(height: 30),
                  _songPlayer(context) // Display the song player controls.
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  // Widget to display the song cover image.
  Widget _songCover(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2, // Half of the screen height.
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            // Load the cover image from the constructed URL.
              '${AppURLs.coverFirestorage}${songEntity.artist} - ${songEntity.title}.jpg?${AppURLs.mediaAlt}'
          ),
        ),
      ),
    );
  }

  // Widget to display the song title and artist along with a favorite button.
  Widget _songDetail() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              songEntity.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              songEntity.artist,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
          ],
        ),
        FavoriteButton(
          songEntity: songEntity, // Button to mark the song as favorite.
        )
      ],
    );
  }

  // Widget to display the song player controls, including a slider and play/pause button.
  Widget _songPlayer(BuildContext context) {
    return BlocBuilder<SongPlayerCubit, SongPlayerState>(
      builder: (context, state) {
        if (state is SongPlayerLoading) {
          return const CircularProgressIndicator(); // Show a loading indicator while the song is loading.
        }
        if (state is SongPlayerLoaded) {
          return Column(
            children: [
              Slider(
                  value: context.read<SongPlayerCubit>().songPosition.inSeconds.toDouble(),
                  min: 0.0,
                  max: context.read<SongPlayerCubit>().songDuration.inSeconds.toDouble(),
                  onChanged: (value) {
                    // TODO: Implement slider functionality to seek through the song.
                  }
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      formatDuration(
                          context.read<SongPlayerCubit>().songPosition // Display the current song position.
                      )
                  ),
                  Text(
                      formatDuration(
                          context.read<SongPlayerCubit>().songDuration // Display the total duration of the song.
                      )
                  ),
                ],
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  context.read<SongPlayerCubit>().playOrPauseSong(); // Handle play/pause toggle.
                },
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary // Set the button color.
                  ),
                  child: Icon(
                      context.read<SongPlayerCubit>().audioPlayer.playing
                          ? Icons.pause
                          : Icons.play_arrow // Change icon based on playing state.
                  ),
                ),
              )
            ],
          );
        }

        return Container(); // Default case if no relevant state is found.
      },
    );
  }

  // Helper function to format a Duration into a string.
  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}'; // Format to MM:SS.
  }
}
