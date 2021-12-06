import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';
import 'app_fonts.dart';

ThemeData appTheme() {
  return ThemeData(
    scaffoldBackgroundColor: AppColors.light,
    fontFamily: AppFonts.quicksand,
    appBarTheme: appBarTheme(),
    textTheme: textTheme(),
    iconTheme: iconThemeData(),
    // inputDecorationTheme: inputDecorationTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

TextTheme textTheme() {
  return const TextTheme(
    bodyText1: TextStyle(color: AppColors.primary),
    bodyText2: TextStyle(color: AppColors.primary),
  );
}

IconThemeData iconThemeData() {
  return const IconThemeData(color: AppColors.secondary);
}

AppBarTheme appBarTheme() {
  return const AppBarTheme(
    color: AppColors.primary,
    elevation: 10,
    systemOverlayStyle: SystemUiOverlayStyle.light,
    iconTheme: IconThemeData(color: AppColors.secondary),
    titleTextStyle: TextStyle(
      color: AppColors.secondary,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
  );
}
