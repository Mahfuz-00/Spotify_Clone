/// A utility class that contains constant URLs used for accessing media resources, 
/// such as song files and cover images from Firebase Storage, as well as a default image URL.
///
/// This class provides a centralized place to store and manage URLs, ensuring consistency
/// throughout the app when interacting with external media resources.
class AppURLs {

  // Base URL for accessing cover images stored on Firebase Storage.
  static const coverFirestorage = 'https://firebasestorage.googleapis.com/v0/b/spotify0101.appspot.com/o/covers%2F';

  // Base URL for accessing song files stored on Firebase Storage.
  static const songFirestorage = 'https://firebasestorage.googleapis.com/v0/b/spotify0101.appspot.com/o/songs%2F';

  // URL parameter used to access media directly (e.g., for streaming purposes).
  static const mediaAlt = 'alt=media';

  // URL for a default image in case the cover image or song art is unavailable.
  static const defaultImage = 'https://cdn-icons-png.flaticon.com/512/10542/10542486.png';
}
