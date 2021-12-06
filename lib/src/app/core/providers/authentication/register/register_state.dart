part of 'register_cubit.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();
}

class RegisterInitial extends RegisterState {
  @override
  List<Object> get props => [];
}

class RegisterLoading extends RegisterState {
  @override
  List<Object?> get props => [];
}

class RegisterSuccess extends RegisterState {
  @override
  List<Object?> get props => [];
}

class RegisterScreenReady extends RegisterState {
  @override
  List<Object?> get props => [];
}

class RegisterError extends RegisterState {
  final String message;

  const RegisterError({required this.message});

  @override
  List<Object?> get props => [message];
}
