import 'package:get_it/get_it.dart';
import 'package:spotify/data/repository/auth/auth_repository_impl.dart';
import 'package:spotify/data/sources/auth/auth_firebase_service.dart';
import 'package:spotify/domain/repository/auth/auth.dart';
import 'package:spotify/domain/usecases/auth/get_user.dart';
import 'package:spotify/domain/usecases/auth/signup.dart';
import 'package:spotify/domain/usecases/song/add_or_remove_favorite_song.dart';
import 'package:spotify/domain/usecases/song/get_favorite_songs.dart';
import 'package:spotify/domain/usecases/song/get_news_songs.dart';
import 'package:spotify/domain/usecases/song/get_play_list.dart';
import 'package:spotify/domain/usecases/song/is_favorite_song.dart';

import 'data/repository/song/song_repository_impl.dart';
import 'data/sources/song/song_firebase_service.dart';
import 'domain/repository/song/song.dart';
import 'domain/usecases/auth/sigin.dart';

final sl = GetIt.instance;

/// Initializes and registers the dependencies for the application using GetIt.
///
/// This function is responsible for setting up the service locator
/// with the necessary implementations of services, repositories, and use cases.
///
/// It registers the following dependencies:
/// - [AuthFirebaseService]: Implementation for Firebase authentication services.
/// - [SongFirebaseService]: Implementation for Firebase song services.
/// - [AuthRepository]: Implementation of the authentication repository.
/// - [SongsRepository]: Implementation of the songs repository.
/// - [SignupUseCase]: Use case for signing up a new user.
/// - [SigninUseCase]: Use case for signing in an existing user.
/// - [GetNewsSongsUseCase]: Use case for retrieving the latest songs.
/// - [GetPlayListUseCase]: Use case for retrieving the playlist.
/// - [AddOrRemoveFavoriteSongUseCase]: Use case for adding or removing a favorite song.
/// - [IsFavoriteSongUseCase]: Use case for checking if a song is a favorite.
/// - [GetUserUseCase]: Use case for retrieving the current user.
/// - [GetFavoriteSongsUseCase]: Use case for retrieving the user's favorite songs.
Future<void> initializeDependencies() async {

 sl.registerSingleton<AuthFirebaseService>(
     AuthFirebaseServiceImpl()
 );

 sl.registerSingleton<SongFirebaseService>(
     SongFirebaseServiceImpl()
 );

 sl.registerSingleton<AuthRepository>(
     AuthRepositoryImpl()
 );

 sl.registerSingleton<SongsRepository>(
     SongRepositoryImpl()
 );

 sl.registerSingleton<SignupUseCase>(
     SignupUseCase()
 );

 sl.registerSingleton<SigninUseCase>(
     SigninUseCase()
 );

 sl.registerSingleton<GetNewsSongsUseCase>(
     GetNewsSongsUseCase()
 );

 sl.registerSingleton<GetPlayListUseCase>(
     GetPlayListUseCase()
 );

 sl.registerSingleton<AddOrRemoveFavoriteSongUseCase>(
     AddOrRemoveFavoriteSongUseCase()
 );

 sl.registerSingleton<IsFavoriteSongUseCase>(
     IsFavoriteSongUseCase()
 );

 sl.registerSingleton<GetUserUseCase>(
     GetUserUseCase()
 );

 sl.registerSingleton<GetFavoriteSongsUseCase>(
     GetFavoriteSongsUseCase()
 );
}
