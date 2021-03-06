import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure([List properties = const <dynamic>[]]);
}

// // General failures
// class ServerFailure extends Failure {
//   final String message;
//
//   const ServerFailure({required this.message});
//
//   @override
//   List<Object?> get props => [message];
// }
//
// class CacheFailure extends Failure {
//   @override
//   List<Object?> get props => [];
// }

class ApiFailure extends Failure {
  final String message;

  const ApiFailure({required this.message});

  @override
  List<Object?> get props => [message];
}