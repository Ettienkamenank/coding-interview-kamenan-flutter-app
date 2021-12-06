import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:coding_interview_flutter_app/src/domain/announcement/model/announcement.dart';
import 'package:coding_interview_flutter_app/src/domain/announcement/port/announcement_domain.dart';
import 'package:coding_interview_flutter_app/src/shared/errors/failures.dart';
import 'package:coding_interview_flutter_app/src/shared/shared_preference_keys.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    required this.getAllAnnouncements,
    required this.prefs,
  }) : super(HomeInitial());

  final IGetAllAnnouncements getAllAnnouncements;
  final SharedPreferences prefs;

  /// Load consumptions
  // Future<Either<String, List<Announcement>>> loadAnnouncements(
  //   String sessionToken,
  // ) async {
  //   final Either<Failure, List<Announcement>> response =
  //       await getAllAnnouncements.getAllAnnouncements(
  //           sessionToken: sessionToken);
  //
  //   return response.fold(
  //     (failure) {
  //       switch (failure.runtimeType) {
  //         case ApiFailure:
  //           {
  //             ApiFailure apiFailure = failure as ApiFailure;
  //             return Left(apiFailure.message);
  //           }
  //         default:
  //           return const Left('Unexpected Error');
  //       }
  //     },
  //     (data) => Right(data),
  //   );
  // }

  /// Set up screen
  void setUpScreen() {
    Timer(
      const Duration(seconds: 1),
      () async {
        final String token = prefs.getString(prefsSessionToken) ?? '';

        if (token.isNotEmpty) {
          final Either<Failure, List<Announcement>> response =
              await getAllAnnouncements.getAllAnnouncements(
                  sessionToken: token);

          emit(response.fold(
            (failure) {
              switch (failure.runtimeType) {
                case ApiFailure:
                  {
                    ApiFailure apiFailure = failure as ApiFailure;
                    return HomeError(message: apiFailure.message);
                  }
                default:
                  return const HomeError(message: 'Unexpected Error');
              }
            },
            (data) {
              return HomeScreenReady(announcements: data);
            },
          ));
        }
      },
    );
  }

//END OF CUBIT CLASS
}
