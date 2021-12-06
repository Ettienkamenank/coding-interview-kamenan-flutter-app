import 'package:coding_interview_flutter_app/src/app/core/providers/authentication/sign_in/sign_in_cubit.dart';
import 'package:coding_interview_flutter_app/src/app/core/providers/splash/splash_cubit.dart';
import 'package:coding_interview_flutter_app/src/coding_interview.dart';
import 'package:coding_interview_flutter_app/src/domain/user/manager/user_manager.dart';
import 'package:coding_interview_flutter_app/src/domain/user/port/user_domain.dart';
import 'package:coding_interview_flutter_app/src/infrastructure/config/request_interceptor.dart';
import 'package:coding_interview_flutter_app/src/infrastructure/repositories/activity_area_repository.dart';
import 'package:coding_interview_flutter_app/src/infrastructure/repositories/announcement_repository.dart';
import 'package:coding_interview_flutter_app/src/infrastructure/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  UnauthenticatedHttpClient unauthenticatedHttpClient =
      UnauthenticatedHttpClient();
  HttpClient httpClient = HttpClient(prefs: prefs);

  /// Repositories
  UserRepository userRepository = UserRepository(
    unauthenticatedHttpClient: unauthenticatedHttpClient,
    httpClient: httpClient,
  );
  ActivityAreaRepository activityAreaRepository =
      ActivityAreaRepository(httpClient: httpClient);
  AnnouncementRepository announcementRepository =
      AnnouncementRepository(httpClient: httpClient);

  /// Use cases
  SignInImpl signInImpl = userRepository;
  ISignIn signIn = SignInUseCase(repository: signInImpl);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SplashCubit(prefs: prefs)),
        BlocProvider(
          create: (context) => SignInCubit(signIn: signIn, prefs: prefs),
        ),
      ],
      child: const CodingInterview(),
    ),
  );
}
