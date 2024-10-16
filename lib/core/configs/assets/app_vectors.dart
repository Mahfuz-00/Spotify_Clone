/// A utility class that contains constant paths for vector assets (SVGs) used in the app.
///
/// This class stores the paths for various vector images, making them easily accessible
/// from a single location. The paths are constructed using a base path (`basePath`) and a 
/// file format (`format`), ensuring consistency across the app.
class AppVectors {

  // Base path for all vector assets (SVG files).
  static const String basePath = 'assets/vectors/';

  // File format for all vectors (in this case, SVG format).
  static const String format = '.svg';

  // Path for the Spotify logo vector.
  static const String logo = '${basePath}spotify_logo$format';

  // Path for the sun icon vector.
  static const String sun = '${basePath}sun$format';

  // Path for the moon icon vector.
  static const String moon = '${basePath}moon$format';

  // Path for the top pattern vector.
  static const String topPattern = '${basePath}top_pattern$format';

  // Path for the bottom pattern vector.
  static const String bottomPattern = '${basePath}bottom_pattern$format';

  // Path for the home top card vector.
  static const String homeTopCard = '${basePath}home_top_card$format';
}
