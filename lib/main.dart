import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:spotify/core/configs/theme/app_theme.dart';
import 'package:spotify/presentation/choose_mode/bloc/theme_cubit.dart';
import 'package:spotify/presentation/splash/pages/splash.dart';

import 'firebase_options.dart';
import 'service_locator.dart';

/// The entry point of the application.
///
/// This function initializes the necessary dependencies,
/// Firebase, and sets up the storage for hydrated bloc.
///
/// It performs the following tasks:
/// 1. Ensures Flutter widgets are initialized.
/// 2. Sets up hydrated bloc storage for state persistence.
/// 3. Initializes Firebase with the default options.
/// 4. Calls the function to initialize dependencies for the application.
/// 5. Runs the main application widget.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Build the storage for HydratedBloc
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );

  // Initialize Firebase
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );

  // Initialize app dependencies
  await initializeDependencies();

  // Run the application
  runApp(const MyApp());
}

/// The root widget of the application.
///
/// This widget sets up the [MultiBlocProvider] to provide the theme
/// cubit to the widget tree and uses a [BlocBuilder] to rebuild the
/// UI based on the current theme mode.
///
/// It returns a [MaterialApp] configured with light and dark themes,
/// and a splash page as the home screen.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()) // Provides the ThemeCubit
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, mode) => MaterialApp(
            theme: AppTheme.lightTheme, // Light theme
            darkTheme: AppTheme.darkTheme, // Dark theme
            themeMode: mode, // Current theme mode from ThemeCubit
            debugShowCheckedModeBanner: false, // Hides the debug banner
            home: const SplashPage() // Home page
        ),
      ),
    );
  }
}
