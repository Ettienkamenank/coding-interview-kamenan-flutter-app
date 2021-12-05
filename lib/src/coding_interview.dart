import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

import 'app/config/app_theme.dart';
import 'app/core/screens/splash/splash_screen.dart';

class CodingInterview extends StatelessWidget {
  const CodingInterview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: appTheme(),
      debugShowCheckedModeBanner: false,
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      home: const SplashScreen(),
    );
  }
}
