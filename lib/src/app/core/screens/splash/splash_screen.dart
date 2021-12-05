import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:coding_interview_flutter_app/src/app/config/app_colors.dart';
import 'package:coding_interview_flutter_app/src/app/config/app_screen_size.dart';
import 'package:coding_interview_flutter_app/src/app/core/providers/splash/splash_cubit.dart';
import 'package:coding_interview_flutter_app/src/app/core/screens/authentication/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initialLoad();
  }

  @override
  Widget build(BuildContext context) {
    AppScreenSize().init(context);

    return Scaffold(
      // backgroundColor: AppColors.primaryLight,
      body: AnimatedSplashScreen(
        splashIconSize: 150,
        // splash: Image.asset(AppFiles.logo, fit: BoxFit.cover,),
        splash: FlutterLogo(size: getScreenWidth(100)),
        nextScreen: BlocBuilder<SplashCubit, SplashState>(
          builder: (context, state) {
            if (state is FirstConnexionState) {
              return const LoginScreen();
            } else if (state is UnauthenticatedState) {
              return const LoginScreen();
            } else if (state is AuthenticatedState) {
              // return HomeScreen();
              return const LoginScreen();
            } else {
              return const LoginScreen();
            }
          },
        ),
        splashTransition: SplashTransition.sizeTransition,
        pageTransitionType: PageTransitionType.rightToLeftWithFade,
        backgroundColor: AppColors.primaryLight,
      ),
    );
  }


  void _initialLoad() {
    BlocProvider.of<SplashCubit>(context).chooseNextScreen();
  }

  //END OF CLASS
}
