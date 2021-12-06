part of 'create_announcement_cubit.dart';

abstract class CreateAnnouncementState extends Equatable {
  const CreateAnnouncementState();
}

class CreateAnnouncementInitial extends CreateAnnouncementState {
  @override
  List<Object> get props => [];
}

class CreateAnnouncementReady extends CreateAnnouncementState {
  const CreateAnnouncementReady({
    required this.areas,
    required this.selectedActivityArea,
  });

  final List<ActivityArea> areas;
  final ActivityArea selectedActivityArea;

  @override
  List<Object> get props => [areas, selectedActivityArea];
}

class CreateAnnouncementLoading extends CreateAnnouncementState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class CreateAnnouncementSuccess extends CreateAnnouncementState {
  const CreateAnnouncementSuccess({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}

/// Load city districts
class CreateAnnouncementLoadAreas extends CreateAnnouncementState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

/// Error state
class CreateAnnouncementError extends CreateAnnouncementState {
  const CreateAnnouncementError({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}
