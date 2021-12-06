import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:coding_interview_flutter_app/src/domain/user/model/user.dart';
import 'package:coding_interview_flutter_app/src/domain/user/port/user_domain.dart';
import 'package:coding_interview_flutter_app/src/shared/errors/failures.dart';
import 'package:coding_interview_flutter_app/src/shared/errors/success.dart';
import 'package:coding_interview_flutter_app/src/shared/shared_preference_keys.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit({
    required this.registerUser,
    required this.prefs,
  }) : super(RegisterInitial());

  final IRegisterUser registerUser;
  final SharedPreferences prefs;

  /// Method for verify if client exist
  void registerUserEvent(
    String firstname,
    String lastname,
    String email,
    String username,
    String phoneNumber,
    String password,
  ) async {
    emit(RegisterLoading());

    var dtoUser = DtoUser(
      firstname: firstname,
      lastname: lastname,
      username: username,
      email: email,
      phoneNumber: phoneNumber,
      password: password,
    );

    Either<Failure, ApiSuccess<bool>> result =
        await registerUser.registerUser(dtoUser: dtoUser);

    emit(result.fold(
      (failure) {
        switch (failure.runtimeType) {
          case ApiFailure:
            {
              ApiFailure apiFailure = failure as ApiFailure;
              return RegisterError(message: apiFailure.message);
            }
          default:
            return const RegisterError(message: 'Unexpected Error');
        }
      },
      (data) {
        prefs.setString(prefsUserIdentifier, username);
        return RegisterSuccess();
      },
    ));
  }

  /// Set up screen
  void setUpScreen() {
    Timer(
      const Duration(seconds: 1),
      () {
        emit(RegisterScreenReady());
      },
    );
  }

//END OF CUBIT CLASS
}
