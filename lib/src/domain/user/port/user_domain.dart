import 'package:coding_interview_flutter_app/src/domain/user/model/user.dart';
import 'package:coding_interview_flutter_app/src/shared/errors/failures.dart';
import 'package:coding_interview_flutter_app/src/shared/errors/success.dart';
import 'package:dartz/dartz.dart';

/// User registration
abstract class IRegisterUser {
  Future<Either<Failure, ApiSuccess<bool>>> registerUser({
    required DtoUser dtoUser,
  });
}

abstract class RegisterUserImpl {
  Future<Either<Failure, ApiSuccess<bool>>> registerUserImpl({
    required DtoUser dtoUser,
  });
}

/// Sign in
abstract class ISignIn {
  Future<Either<Failure, User>> signIn({
    required String username,
    required String password,
  });
}

abstract class SignInImpl {
  Future<Either<Failure, User>> signInImpl({
    required String username,
    required String password,
  });
}

/// Logout
abstract class ILogout {
  Future<Either<Failure, ApiSuccess<bool>>> logout();
}

abstract class LogoutImpl {
  Future<Either<Failure, ApiSuccess<bool>>> logoutImpl();
}
