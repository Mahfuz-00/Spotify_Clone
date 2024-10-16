import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/domain/usecases/auth/get_user.dart';
import 'package:spotify/presentation/profile/bloc/profile_info_state.dart';
import 'package:spotify/service_locator.dart';

/// Cubit responsible for managing the state of user profile information.
class ProfileInfoCubit extends Cubit<ProfileInfoState> {

  /// Initializes the cubit with a loading state.
  ProfileInfoCubit() : super(ProfileInfoLoading());

  /// Fetches the user profile information.
  Future<void> getUser() async {
    // Calls the GetUserUseCase to retrieve the user information.
    var user = await sl<GetUserUseCase>().call();

    // Handles the result of the use case.
    user.fold(
            (failure) {
          // Emitting failure state if there was an error retrieving the user information.
          emit(ProfileInfoFailure());
        },
            (userEntity) {
          // Emitting loaded state with the retrieved user information.
          emit(ProfileInfoLoaded(userEntity: userEntity));
        }
    );
  }
}
