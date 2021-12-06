import 'package:coding_interview_flutter_app/src/domain/announcement/model/announcement.dart';
import 'package:coding_interview_flutter_app/src/shared/errors/failures.dart';
import 'package:coding_interview_flutter_app/src/shared/errors/success.dart';
import 'package:dartz/dartz.dart';

/// Get All Announcements
abstract class IGetAllAnnouncements {
  Future<Either<Failure, List<Announcement>>> getAllAnnouncements({
    required String sessionToken,
  });
}

abstract class GetAllAnnouncementsImpl {
  Future<Either<Failure, List<Announcement>>> getAllAnnouncementsImpl({
    required String sessionToken,
  });
}

/// Create Announcement
abstract class ICreateAnnouncement {
  Future<Either<Failure, ApiSuccess<bool>>> createAnnouncement({
    required String sessionToken,
    required DtoAnnouncement dtoAnnouncement,
  });
}

abstract class CreateAnnouncementImpl {
  Future<Either<Failure, ApiSuccess<bool>>> createAnnouncementImpl({
    required String sessionToken,
    required DtoAnnouncement dtoAnnouncement,
  });
}

/// Report Announcement
abstract class IReportAnnouncement {
  Future<Either<Failure, ApiSuccess<bool>>> reportAnnouncement({
    required String sessionToken,
    required DtoActionOnAnnouncement actionOnAnnouncement,
  });
}

abstract class ReportAnnouncementImpl {
  Future<Either<Failure, ApiSuccess<bool>>> reportAnnouncementImpl({
    required String sessionToken,
    required DtoActionOnAnnouncement actionOnAnnouncement,
  });
}

/// Comment Announcement
abstract class ICommentAnnouncement {
  Future<Either<Failure, ApiSuccess<bool>>> commentAnnouncement({
    required String sessionToken,
    required DtoActionOnAnnouncement actionOnAnnouncement,
  });
}

abstract class CommentAnnouncementImpl {
  Future<Either<Failure, ApiSuccess<bool>>> commentAnnouncementImpl({
    required String sessionToken,
    required DtoActionOnAnnouncement actionOnAnnouncement,
  });
}
