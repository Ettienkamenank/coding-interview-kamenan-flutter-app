import 'dart:convert';

import 'package:coding_interview_flutter_app/src/domain/user/model/user.dart';
import 'package:coding_interview_flutter_app/src/domain/user/port/user_domain.dart';
import 'package:coding_interview_flutter_app/src/infrastructure/config/api_endpoint.dart';
import 'package:coding_interview_flutter_app/src/infrastructure/config/request_interceptor.dart';
import 'package:coding_interview_flutter_app/src/shared/errors/failures.dart';
import 'package:coding_interview_flutter_app/src/shared/errors/success.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class UserRepository implements RegisterUserImpl, SignInImpl, LogoutImpl {
  UserRepository({required this.client});

  final http.Client client;

  String baseUrl = ApiEndpoint.authenticationEndpoint;
  String secureBaseUrl = ApiEndpoint.userEndpoint;

  @override
  Future<Either<Failure, ApiSuccess<bool>>> logoutImpl({
    required String sessionToken,
  }) async {
    Uri url = Uri.parse('$secureBaseUrl/logout');

    try {
      final response = await client.post(
        url,
        headers: appHttpHeaders(sessionToken: sessionToken),
      );

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
      final response = await client.post(
        url,
        headers: appHttpHeaders(sessionToken: null),
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
      final response = await client.post(
        url,
        headers: appHttpHeaders(sessionToken: null),
      );

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
