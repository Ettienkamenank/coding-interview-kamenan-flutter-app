import 'dart:convert';

import 'package:coding_interview_flutter_app/src/domain/user/model/user.dart';
import 'package:coding_interview_flutter_app/src/domain/user/port/user_domain.dart';
import 'package:coding_interview_flutter_app/src/infrastructure/config/api_endpoint.dart';
import 'package:coding_interview_flutter_app/src/infrastructure/config/request_interceptor.dart';
import 'package:coding_interview_flutter_app/src/shared/errors/failures.dart';
import 'package:coding_interview_flutter_app/src/shared/errors/success.dart';
import 'package:dartz/dartz.dart';

class UserRepository implements RegisterUserImpl, SignInImpl, LogoutImpl {
  UserRepository({
    required this.unauthenticatedHttpClient,
    required this.httpClient,
  });

  final UnauthenticatedHttpClient unauthenticatedHttpClient;
  final HttpClient httpClient;

  String baseUrl = ApiEndpoint.authenticationEndpoint;
  String secureBaseUrl = ApiEndpoint.userEndpoint;

  @override
  Future<Either<Failure, ApiSuccess<bool>>> logoutImpl() async {
    Uri url = Uri.parse('$secureBaseUrl/logout');

    try {
      final response = await httpClient.post(url);

      switch (response.statusCode) {
        case 200:
          {
            final resJson = json.decode(response.body);

            if (resJson['error']) {
              return Left(ApiFailure(message: resJson['message']));
            } else {
              return Right(
                ApiSuccess(message: resJson['message'], T: true),
              );
            }
          }
        default:
          {
            return const Left(
              ApiFailure(message: 'Erreur serveur, essayé plus tard!!!'),
            );
          }
      }
    } catch (err) {
      return Left(ApiFailure(message: err.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiSuccess<bool>>> registerUserImpl({
    required DtoUser dtoUser,
  }) async {
    // var requestBody = {
    //   'firstname': dtoUser.firstname,
    //   'lastname': dtoUser.lastname,
    //   'username': dtoUser.username,
    //   'email': dtoUser.email,
    //   'phoneNumber': dtoUser.phoneNumber,
    //   'password': dtoUser.password,
    // };
    var requestBody = json.encode({
      "firstname": dtoUser.firstname,
      "lastname": dtoUser.lastname,
      "username": dtoUser.username,
      "email": dtoUser.email,
      "phoneNumber": dtoUser.phoneNumber,
      "password": dtoUser.password,
    });

    Uri url = Uri.parse('$baseUrl/create');

    try {
      final response = await unauthenticatedHttpClient.post(
        url,
        body: requestBody,
      );

      switch (response.statusCode) {
        case 200:
          {
            final resJson = json.decode(response.body);

            if (resJson['error']) {
              return Left(ApiFailure(message: resJson['message']));
            } else {
              return Right(ApiSuccess(message: resJson['message'], T: true));
            }
          }
        default:
          {
            return const Left(
              ApiFailure(message: 'Erreur serveur, essayé plus tard!!!'),
            );
          }
      }
    } catch (err) {
      return Left(ApiFailure(message: err.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> signInImpl({
    required String username,
    required String password,
  }) async {
    var requestParam = {'username': username, 'password': password};
    String queryString = Uri(queryParameters: requestParam).query;

    Uri url = Uri.parse('$baseUrl/authenticate?$queryString');

    try {
      final response = await unauthenticatedHttpClient.post(url);

      switch (response.statusCode) {
        case 200:
          {
            final resJson = json.decode(response.body);

            if (resJson['error']) {
              return Left(ApiFailure(message: resJson['message']));
            } else {
              User user = User.fromJson(resJson['data']);
              return Right(user);
            }
          }
        default:
          {
            return const Left(
              ApiFailure(message: 'Erreur serveur, essayé plus tard!!!'),
            );
          }
      }
    } catch (err) {
      return Left(ApiFailure(message: err.toString()));
    }
  }
}
