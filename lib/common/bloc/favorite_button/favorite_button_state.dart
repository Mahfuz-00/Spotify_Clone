/// An abstract class representing the state of the favorite button.
/// This serves as a base class for specific favorite button states.
abstract class FavoriteButtonState {}

/// Represents the initial state of the favorite button.
/// It indicates that the button is in its default state before any user interaction.
class FavoriteButtonInitial extends FavoriteButtonState {}

/// Represents the updated state of the favorite button.
/// This state is emitted when the favorite status of a song changes.
/// 
/// The `isFavorite` property indicates whether the song is currently marked as a favorite.
class FavoriteButtonUpdated extends FavoriteButtonState {
  final bool isFavorite; // Indicates if the song is a favorite.

  /// Constructor to create an instance of `FavoriteButtonUpdated`.
  /// 
  /// Takes a required parameter `isFavorite` to set the favorite status.
  FavoriteButtonUpdated({required this.isFavorite});
}
