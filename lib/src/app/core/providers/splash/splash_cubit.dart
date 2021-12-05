import 'package:bloc/bloc.dart';
import 'package:coding_interview_flutter_app/src/shared/shared_preference_keys.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit({required this.prefs}) : super(SplashInitial());

  final SharedPreferences prefs;

  void chooseNextScreen() {
    bool firstConnexion = prefs.getBool(prefsFirstConnexion) ?? true;
    String sessionToken = prefs.getString(prefsSessionToken) ?? '';

    if (firstConnexion) {
      emit(FirstConnexionState());
    }  else {
      if (sessionToken.isEmpty) {
        emit(UnauthenticatedState());
      }  else {
        emit(AuthenticatedState());
      }
    }
  }
}
