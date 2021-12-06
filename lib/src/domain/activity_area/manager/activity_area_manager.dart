import 'package:coding_interview_flutter_app/src/domain/activity_area/model/activity_area.dart';
import 'package:coding_interview_flutter_app/src/domain/activity_area/port/activity_area_domain.dart';
import 'package:coding_interview_flutter_app/src/shared/errors/failures.dart';
import 'package:dartz/dartz.dart';

class GetAllActivityAreasUseCase implements IGetAllActivityAreas {
  GetAllActivityAreasUseCase({required this.repository});

  final GetAllActivityAreasImpl repository;

  @override
  Future<Either<Failure, List<ActivityArea>>> getAllActivityAreas({
    required String sessionToken,
  }) async {
    return await repository.getAllActivityAreasImpl(sessionToken: sessionToken);
  }
}
