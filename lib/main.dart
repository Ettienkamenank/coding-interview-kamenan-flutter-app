import 'package:coding_interview_flutter_app/src/app/core/providers/splash/splash_cubit.dart';
import 'package:coding_interview_flutter_app/src/coding_interview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SplashCubit(prefs: prefs)),
      ],
      child: const CodingInterview(),
    ),
  );

  // runApp(const LungCash());
}
