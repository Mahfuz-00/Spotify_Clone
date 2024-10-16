import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

/// A Cubit class that manages the application's theme state.
/// It extends HydratedCubit to persist the theme mode across app restarts.
class ThemeCubit extends HydratedCubit<ThemeMode> {

  /// Initializes the ThemeCubit with a default theme mode of `ThemeMode.system`.
  ThemeCubit() : super(ThemeMode.system);

  /// Updates the theme mode to the provided [themeMode].
  /// Emits the new theme mode to listeners.
  void updateTheme(ThemeMode themeMode) => emit(themeMode);

  /// Converts the JSON map into a ThemeMode.
  /// Called when restoring state from storage.
  @override
  ThemeMode? fromJson(Map<String, dynamic> json) {
    // Returns the corresponding ThemeMode based on the index stored in JSON.
    return ThemeMode.values[json['theme'] as int];
  }

  /// Converts the current state (ThemeMode) to a JSON map.
  /// Called when saving state to storage.
  @override
  Map<String, dynamic>? toJson(ThemeMode state) {
    // Saves the index of the current theme mode to JSON.
    return {'theme': state.index};
  }
}
