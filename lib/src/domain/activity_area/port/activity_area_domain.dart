import 'package:coding_interview_flutter_app/src/domain/activity_area/model/activity_area.dart';
import 'package:coding_interview_flutter_app/src/shared/errors/failures.dart';
import 'package:dartz/dartz.dart';

/// Get All Activity Areas
abstract class IGetAllActivityAreas {
  Future<Either<Failure, List<ActivityArea>>> getAllActivityAreas();
}

abstract class GetAllActivityAreasImpl {
  Future<Either<Failure, List<ActivityArea>>> getAllActivityAreasImpl();
}