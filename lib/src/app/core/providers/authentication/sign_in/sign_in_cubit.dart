import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:coding_interview_flutter_app/src/domain/user/model/user.dart';
import 'package:coding_interview_flutter_app/src/domain/user/port/user_domain.dart';
import 'package:coding_interview_flutter_app/src/shared/errors/failures.dart';
import 'package:coding_interview_flutter_app/src/shared/shared_preference_keys.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit({
    required this.signIn,
    required this.prefs,
  }) : super(SignInInitial());

  final ISignIn signIn;
  final SharedPreferences prefs;

  /// Sign in method
  void signInEvent(String username, String password) async {
    emit(SignInLoading());

    Either<Failure, User> result = await signIn.signIn(
      username: username,
      password: password,
    );

    emit(result.fold(
      (failure) {
        switch (failure.runtimeType) {
          case ApiFailure:
            {
              ApiFailure apiFailure = failure as ApiFailure;
              return SignInError(message: apiFailure.message);
            }
          default:
            return const SignInError(message: 'Unexpected Error');
        }
      },
      (data) {
        prefs.setString(prefsUser, json.encode(data));
        prefs.setString(prefsUserIdentifier, data.username);
        return SignInSuccess();
      },
    ));
  }

  /// Set up screen
  void setUpScreen() {
    Timer(
      const Duration(seconds: 1),
      () {
        String username = prefs.getString(prefsUserIdentifier) ?? '';
        emit(SignInScreenReady(username: username));
      },
    );
  }

//END OF CUBIT CLASS
}
