part of 'sign_in_cubit.dart';

abstract class SignInState extends Equatable {
  const SignInState();
}

class SignInInitial extends SignInState {
  @override
  List<Object> get props => [];
}

class SignInLoading extends SignInState {
  @override
  List<Object> get props => [];
}

class SignInScreenReady extends SignInState {
  final String username;

  const SignInScreenReady({required this.username});

  @override
  List<Object?> get props => [username];
}

class SignInSuccess extends SignInState {
  @override
  List<Object?> get props => [];
}

class SignInError extends SignInState {
  final String message;

  const SignInError({required this.message});

  @override
  List<Object?> get props => [message];
}
