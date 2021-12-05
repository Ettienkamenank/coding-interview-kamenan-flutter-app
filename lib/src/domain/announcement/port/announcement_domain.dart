import 'package:coding_interview_flutter_app/src/domain/announcement/model/announcement.dart';
import 'package:coding_interview_flutter_app/src/shared/errors/failures.dart';
import 'package:coding_interview_flutter_app/src/shared/errors/success.dart';
import 'package:dartz/dartz.dart';

/// Get All Announcements
abstract class IGetAllAnnouncements {
  Future<Either<Failure, List<Announcement>>> getAllAnnouncements();
}

abstract class GetAllAnnouncementsImpl {
  Future<Either<Failure, List<Announcement>>> getAllAnnouncementsImpl();
}

/// Create Announcement
abstract class ICreateAnnouncement {
  Future<Either<Failure, ApiSuccess<bool>>> createAnnouncement({
    required DtoAnnouncement dtoAnnouncement,
  });
}

abstract class CreateAnnouncementImpl {
  Future<Either<Failure, ApiSuccess<bool>>> createAnnouncementImpl({
    required DtoAnnouncement dtoAnnouncement,
  });
}

/// Report Announcement
abstract class IReportAnnouncement {
  Future<Either<Failure, ApiSuccess<bool>>> createAnnouncement({
    required DtoActionOnAnnouncement actionOnAnnouncement,
  });
}

abstract class ReportAnnouncementImpl {
  Future<Either<Failure, ApiSuccess<bool>>> createAnnouncementImpl({
    required DtoActionOnAnnouncement actionOnAnnouncement,
  });
}

/// Comment Announcement
abstract class ICommentAnnouncement {
  Future<Either<Failure, ApiSuccess<bool>>> commentAnnouncement({
    required DtoActionOnAnnouncement actionOnAnnouncement,
  });
}

abstract class CommentAnnouncementImpl {
  Future<Either<Failure, ApiSuccess<bool>>> commentAnnouncementImpl({
    required DtoActionOnAnnouncement actionOnAnnouncement,
  });
}
