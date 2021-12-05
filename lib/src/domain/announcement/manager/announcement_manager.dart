import 'package:coding_interview_flutter_app/src/domain/announcement/model/announcement.dart';
import 'package:coding_interview_flutter_app/src/domain/announcement/port/announcement_domain.dart';
import 'package:coding_interview_flutter_app/src/shared/errors/failures.dart';
import 'package:coding_interview_flutter_app/src/shared/errors/success.dart';
import 'package:dartz/dartz.dart';

class GetAllAnnouncementsUseCase implements IGetAllAnnouncements {
  GetAllAnnouncementsUseCase({required this.repository});

  final GetAllAnnouncementsImpl repository;

  @override
  Future<Either<Failure, List<Announcement>>> getAllAnnouncements() async {
    return await repository.getAllAnnouncementsImpl();
  }
}

class CreateAnnouncementUseCase implements ICreateAnnouncement {
  CreateAnnouncementUseCase({required this.repository});

  final CreateAnnouncementImpl repository;

  @override
  Future<Either<Failure, ApiSuccess<bool>>> createAnnouncement({
    required DtoAnnouncement dtoAnnouncement,
  }) async {
    return await repository.createAnnouncementImpl(
      dtoAnnouncement: dtoAnnouncement,
    );
  }
}

class ReportAnnouncementUseCase implements IReportAnnouncement {
  ReportAnnouncementUseCase({required this.repository});

  final ReportAnnouncementImpl repository;

  @override
  Future<Either<Failure, ApiSuccess<bool>>> reportAnnouncement({
    required DtoActionOnAnnouncement actionOnAnnouncement,
  }) async {
    return await repository.reportAnnouncementImpl(
      actionOnAnnouncement: actionOnAnnouncement,
    );
  }
}

class CommentAnnouncementUseCase implements ICommentAnnouncement {
  CommentAnnouncementUseCase({required this.repository});

  final CommentAnnouncementImpl repository;

  @override
  Future<Either<Failure, ApiSuccess<bool>>> commentAnnouncement({
    required DtoActionOnAnnouncement actionOnAnnouncement,
  }) async {
    return await repository.commentAnnouncementImpl(
      actionOnAnnouncement: actionOnAnnouncement,
    );
  }
}
