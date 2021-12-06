import 'dart:convert';

import 'package:coding_interview_flutter_app/src/domain/activity_area/model/activity_area.dart';
import 'package:coding_interview_flutter_app/src/domain/activity_area/port/activity_area_domain.dart';
import 'package:coding_interview_flutter_app/src/infrastructure/config/api_endpoint.dart';
import 'package:coding_interview_flutter_app/src/infrastructure/config/request_interceptor.dart';
import 'package:coding_interview_flutter_app/src/shared/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class ActivityAreaRepository implements GetAllActivityAreasImpl {
  ActivityAreaRepository({required this.client});

  final http.Client client;
  String baseUrl = ApiEndpoint.activityAreaEndpoint;

  List<ActivityArea> activityAreasCached = [];

  @override
  Future<Either<Failure, List<ActivityArea>>> getAllActivityAreasImpl({
    required String sessionToken,
  }) async {
    if (activityAreasCached.isEmpty) {
      Uri url = Uri.parse('$baseUrl/all-activity-areas');

      try {
        final response = await client.get(
          url,
          headers: appHttpHeaders(sessionToken: sessionToken),
        );

        switch (response.statusCode) {
          case 200:
            {
              final resJson = json.decode(response.body);

              if (resJson['error']) {
                return Left(ApiFailure(message: resJson['message']));
              } else {
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
