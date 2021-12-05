import 'package:equatable/equatable.dart';

abstract class Success extends Equatable {
  const Success([List properties = const <dynamic>[]]);
}

// General success
class ApiSuccess<T> extends Success {
  const ApiSuccess({required this.message, required T});

  final String message;

  @override
  List<Object?> get props => [message, T];
}