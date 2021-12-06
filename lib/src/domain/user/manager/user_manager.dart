import 'package:coding_interview_flutter_app/src/domain/user/model/user.dart';
import 'package:coding_interview_flutter_app/src/domain/user/port/user_domain.dart';
import 'package:coding_interview_flutter_app/src/shared/errors/failures.dart';
import 'package:coding_interview_flutter_app/src/shared/errors/success.dart';
import 'package:dartz/dartz.dart';

class RegisterUserUseCase implements IRegisterUser {
  RegisterUserUseCase({required this.repository});

  final RegisterUserImpl repository;

  @override
  Future<Either<Failure, ApiSuccess<bool>>> registerUser({
    required DtoUser dtoUser,
  }) async {
    return await repository.registerUserImpl(dtoUser: dtoUser);
  }
}

class SignInUseCase implements ISignIn {
  SignInUseCase({required this.repository});

  final SignInImpl repository;

  @override
  Future<Either<Failure, User>> signIn({
    required String username,
    required String password,
  }) async {
    return await repository.signInImpl(username: username, password: password);
  }
}

class LogoutUseCase implements ILogout {
  LogoutUseCase({required this.repository});

  final LogoutImpl repository;

  @override
  Future<Either<Failure, ApiSuccess<bool>>> logout({
    required String sessionToken,
  }) async {
    return await repository.logoutImpl(sessionToken: sessionToken);
  }
}
