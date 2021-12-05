import 'dart:convert';

import 'package:coding_interview_flutter_app/src/domain/activity_area/model/activity_area.dart';
import 'package:coding_interview_flutter_app/src/domain/activity_area/port/activity_area_domain.dart';
import 'package:coding_interview_flutter_app/src/infrastructure/config/api_endpoint.dart';
import 'package:coding_interview_flutter_app/src/infrastructure/config/request_interceptor.dart';
import 'package:coding_interview_flutter_app/src/shared/errors/failures.dart';
import 'package:dartz/dartz.dart';

class ActivityAreaRepository implements GetAllActivityAreasImpl {
  ActivityAreaRepository({required this.httpClient});

  final HttpClient httpClient;
  String baseUrl = ApiEndpoint.activityAreaEndpoint;

  List<ActivityArea> activityAreasCached = [];

  @override
  Future<Either<Failure, List<ActivityArea>>> getAllActivityAreasImpl() async {
    if (activityAreasCached.isEmpty) {
      Uri url = Uri.parse('$baseUrl/all-activity-areas');

      try {
        final response = await httpClient.get(url);

        switch (response.statusCode) {
          case 200:
            {
              final resJson = json.decode(response.body);

              if (resJson['summary']['isSuccess']) {
                final values = (resJson['data'] as List);
                List<ActivityArea> activityAreas;

                if (values.isEmpty) {
                  activityAreas = [];
                  return Right(activityAreas);
                } else {
                  activityAreas = values
                      .map((area) => ActivityArea.fromJson(area))
                      .toList();

                  activityAreasCached = activityAreas;

                  return Right(activityAreas);
                }

              } else {
                List<String> errors =
                    (resJson['summary']['errors']).values.toList();

                return Left(ApiFailure(message: errors.first.toString()));
              }
            }
          default:
            {
              return const Left(
                ApiFailure(message: 'Erreur serveur, essayé plus tard!!!'),
              );
            }
        }
      } catch (err) {
        return Left(ApiFailure(message: err.toString()));
      }
    } else {
      return Right(activityAreasCached);
    }
  }
}
