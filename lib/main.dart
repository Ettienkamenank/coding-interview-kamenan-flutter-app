import 'package:coding_interview_flutter_app/src/app/core/providers/authentication/register/register_cubit.dart';
import 'package:coding_interview_flutter_app/src/app/core/providers/authentication/sign_in/sign_in_cubit.dart';
import 'package:coding_interview_flutter_app/src/app/core/providers/home/home_cubit.dart';
import 'package:coding_interview_flutter_app/src/app/core/providers/splash/splash_cubit.dart';
import 'package:coding_interview_flutter_app/src/coding_interview.dart';
import 'package:coding_interview_flutter_app/src/domain/announcement/manager/announcement_manager.dart';
import 'package:coding_interview_flutter_app/src/domain/announcement/port/announcement_domain.dart';
import 'package:coding_interview_flutter_app/src/domain/user/manager/user_manager.dart';
import 'package:coding_interview_flutter_app/src/domain/user/port/user_domain.dart';
import 'package:coding_interview_flutter_app/src/infrastructure/repositories/activity_area_repository.dart';
import 'package:coding_interview_flutter_app/src/infrastructure/repositories/announcement_repository.dart';
import 'package:coding_interview_flutter_app/src/infrastructure/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  http.Client client = http.Client();

  /// Repositories
  UserRepository userRepository = UserRepository(client: client);
  ActivityAreaRepository activityAreaRepository =
      ActivityAreaRepository(client: client);
  AnnouncementRepository announcementRepository =
      AnnouncementRepository(client: client);

  /// Use cases
  SignInImpl signInImpl = userRepository;
  ISignIn signIn = SignInUseCase(repository: signInImpl);

  RegisterUserImpl registerUserImpl = userRepository;
  IRegisterUser registerUser =
      RegisterUserUseCase(repository: registerUserImpl);

  GetAllAnnouncementsImpl getAllAnnouncementsImpl = announcementRepository;
  IGetAllAnnouncements getAllAnnouncements =
      GetAllAnnouncementsUseCase(repository: getAllAnnouncementsImpl);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SplashCubit(prefs: prefs)),
        BlocProvider(
          create: (context) => SignInCubit(signIn: signIn, prefs: prefs),
        ),
        BlocProvider(
          create: (context) => RegisterCubit(
            registerUser: registerUser,
            prefs: prefs,
          ),
        ),
        BlocProvider(
          create: (context) => HomeCubit(
            getAllAnnouncements: getAllAnnouncements,
            prefs: prefs,
          ),
        ),
      ],
      child: const CodingInterview(),
    ),
  );
}
