import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:coding_interview_flutter_app/src/domain/activity_area/model/activity_area.dart';
import 'package:coding_interview_flutter_app/src/domain/activity_area/port/activity_area_domain.dart';
import 'package:coding_interview_flutter_app/src/domain/announcement/model/announcement.dart';
import 'package:coding_interview_flutter_app/src/domain/announcement/port/announcement_domain.dart';
import 'package:coding_interview_flutter_app/src/shared/errors/failures.dart';
import 'package:coding_interview_flutter_app/src/shared/errors/success.dart';
import 'package:coding_interview_flutter_app/src/shared/shared_preference_keys.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'create_announcement_state.dart';

class CreateAnnouncementCubit extends Cubit<CreateAnnouncementState> {
  CreateAnnouncementCubit({
    required this.getAllActivityAreas,
    required this.createAnnouncement,
    required this.prefs,
  }) : super(CreateAnnouncementInitial());

  final IGetAllActivityAreas getAllActivityAreas;
  final ICreateAnnouncement createAnnouncement;
  final SharedPreferences prefs;

  /// Method for verify if client exist
  void createAnnouncementEvent({
    required String title,
    required String description,
    required String activityAreaId,
  }) async {
    emit(CreateAnnouncementLoading());

    final String token = prefs.getString(prefsSessionToken) ?? '';

    if (token.isEmpty) {
      emit(const CreateAnnouncementError(message: 'Session expiré'));
    } else {
      var dtoAnnouncement = DtoAnnouncement(
        title: title,
        description: description,
        activityAreaId: activityAreaId,
      );

      Either<Failure, ApiSuccess<bool>> result =
          await createAnnouncement.createAnnouncement(
        sessionToken: token,
        dtoAnnouncement: dtoAnnouncement,
      );

      emit(result.fold(
        (failure) {
          switch (failure.runtimeType) {
            case ApiFailure:
              {
                ApiFailure apiFailure = failure as ApiFailure;
                return CreateAnnouncementError(message: apiFailure.message);
              }
            default:
              return const CreateAnnouncementError(message: 'Unexpected Error');
          }
        },
        (data) {
          return CreateAnnouncementSuccess(message: data.message);
        },
      ));
    }
  }

  /// Change Area
  void changeArea(ActivityArea area) {
    CreateAnnouncementReady currentState = state as CreateAnnouncementReady;

    emit(CreateAnnouncementLoadAreas());

    emit(CreateAnnouncementReady(
      areas: currentState.areas,
      selectedActivityArea: area,
    ));
  }

  /// Set up screen
  void setUpScreen() {
    Timer(
      const Duration(seconds: 1),
      () async {
        final String token = prefs.getString(prefsSessionToken) ?? '';

        if (token.isNotEmpty) {
          final Either<Failure, List<ActivityArea>> response =
              await getAllActivityAreas.getAllActivityAreas(
            sessionToken: token,
          );

          emit(response.fold(
            (failure) {
              switch (failure.runtimeType) {
                case ApiFailure:
                  {
                    ApiFailure apiFailure = failure as ApiFailure;
                    return CreateAnnouncementError(
                      message: apiFailure.message,
                    );
                  }
                default:
                  return const CreateAnnouncementError(
                    message: 'Unexpected Error',
                  );
              }
            },
            (data) {
              return CreateAnnouncementReady(
                areas: data,
                selectedActivityArea: data.first,
              );
            },
          ));
        }
      },
    );
  }

//END OF CUBIT CLASS
}
