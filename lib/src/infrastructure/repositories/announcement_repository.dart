import 'dart:convert';

import 'package:coding_interview_flutter_app/src/domain/announcement/model/announcement.dart';
import 'package:coding_interview_flutter_app/src/domain/announcement/port/announcement_domain.dart';
import 'package:coding_interview_flutter_app/src/infrastructure/config/api_endpoint.dart';
import 'package:coding_interview_flutter_app/src/infrastructure/config/request_interceptor.dart';
import 'package:coding_interview_flutter_app/src/shared/errors/failures.dart';
import 'package:coding_interview_flutter_app/src/shared/errors/success.dart';
import 'package:dartz/dartz.dart';

class AnnouncementRepository
    implements
        GetAllAnnouncementsImpl,
        CreateAnnouncementImpl,
        ReportAnnouncementImpl,
        CommentAnnouncementImpl {
  AnnouncementRepository({required this.httpClient});

  final HttpClient httpClient;
  String baseUrl = ApiEndpoint.announcementEndpoint;

  List<Announcement> announcementsCached = [];

  @override
  Future<Either<Failure, ApiSuccess<bool>>> commentAnnouncementImpl({
    required DtoActionOnAnnouncement actionOnAnnouncement,
  }) async {
    var requestBody = json.encode({
      "comment": actionOnAnnouncement.comment,
      "announcementId": actionOnAnnouncement.announcementId,
    });

    Uri url = Uri.parse('$baseUrl/comment');

    try {
      final response = await httpClient.post(url, body: requestBody);

      switch (response.statusCode) {
        case 200:
          {
            final resJson = json.decode(response.body);

            if (resJson['error']) {
              return Left(ApiFailure(message: resJson['message']));
            } else {
              return Right(ApiSuccess(message: resJson['message'], T: true));
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
  }

  @override
  Future<Either<Failure, ApiSuccess<bool>>> createAnnouncementImpl({
    required DtoAnnouncement dtoAnnouncement,
  }) async {
    var requestBody = json.encode({
      "title": dtoAnnouncement.title,
      "description": dtoAnnouncement.description,
      "activityAreaId": dtoAnnouncement.activityAreaId,
    });

    Uri url = Uri.parse('$baseUrl/create');

    try {
      final response = await httpClient.post(url, body: requestBody);

      switch (response.statusCode) {
        case 200:
          {
            final resJson = json.decode(response.body);

            if (resJson['error']) {
              return Left(ApiFailure(message: resJson['message']));
            } else {
              return Right(ApiSuccess(message: resJson['message'], T: true));
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
  }

  @override
  Future<Either<Failure, List<Announcement>>> getAllAnnouncementsImpl() async {
    if (announcementsCached.isEmpty) {
      Uri url = Uri.parse('$baseUrl/all-activity-areas');

      try {
        final response = await httpClient.get(url);

        switch (response.statusCode) {
          case 200:
            {
              final resJson = json.decode(response.body);

              if (resJson['error']) {
                return Left(ApiFailure(message: resJson['message']));
              } else {
                final values = (resJson['data'] as List);
                List<Announcement> announcements;

                if (values.isEmpty) {
                  announcements = [];
                  return Right(announcements);
                } else {
                  announcements = values
                      .map((announce) => Announcement.fromJson(announce))
                      .toList();

                  announcementsCached = announcements;

                  return Right(announcements);
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
      return Right(announcementsCached);
    }
  }

  @override
  Future<Either<Failure, ApiSuccess<bool>>> reportAnnouncementImpl({
    required DtoActionOnAnnouncement actionOnAnnouncement,
  }) async {
    var requestBody = json.encode({
      "comment": actionOnAnnouncement.comment,
      "announcementId": actionOnAnnouncement.announcementId,
    });

    Uri url = Uri.parse('$baseUrl/report');

    try {
      final response = await httpClient.post(url, body: requestBody);

      switch (response.statusCode) {
        case 200:
          {
            final resJson = json.decode(response.body);

            if (resJson['error']) {
              return Left(ApiFailure(message: resJson['message']));
            } else {
              return Right(ApiSuccess(message: resJson['message'], T: true));
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
  }
}
