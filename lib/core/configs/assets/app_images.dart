/// A utility class that contains constant paths for image assets used in the app.
///
/// This class stores the paths of various images, making it easier to manage and
/// access them from a central location. The paths are constructed using a base path (`basePath`),
/// and each specific image is stored as a static constant string.
class AppImages {

  // Base path for all image assets, simplifying path management.
  static const String basePath = 'assets/images/';

  // Path for the intro background image.
  static const String introBG = '${basePath}intro_bg.png';

  // Path for the choose mode background image.
  static const String chooseModeBG = '${basePath}choose_mode_bg.png';

  // Path for the authentication background image.
  static const String authBG = '${basePath}auth_bg.png';

  // Path for the home artist image.
  static const String homeArtist = '${basePath}home_artist.png';
}
