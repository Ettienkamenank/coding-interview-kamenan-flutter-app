import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_fonts.dart';
import 'app_screen_size.dart';

/// Corporate const
const areaTitleTextStyle = TextStyle(
  fontFamily: AppFonts.montserrat,
  color: AppColors.primary,
  fontWeight: FontWeight.bold,
  fontSize: 18,
);
const areaTitleTextStyle1 = TextStyle(
  fontFamily: AppFonts.montserrat,
  color: Colors.blueAccent,
  fontSize: 15,
  fontStyle: FontStyle.italic,
  // fontWeight: FontWeight.bold,
);
const areaSubtitleTextStyle = TextStyle(
  color: AppColors.primary,
  fontSize: 18,
);

///
final kHeadingStyle = TextStyle(
  fontSize: getScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const kAppButtonTextStyle = TextStyle(
  fontSize: 18.0,
  color: AppColors.secondary,
  fontWeight: FontWeight.bold,
);

const kAppNamesTextStyle = TextStyle(
  fontSize: 17.0,
  color: AppColors.grey,
  fontWeight: FontWeight.bold,
);

const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [AppColors.primary, AppColors.secondary],
);

final headingStyle = TextStyle(
  fontSize: getScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

final kOtpInputDecoration = InputDecoration(
  contentPadding:
  EdgeInsets.symmetric(vertical: getScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getScreenWidth(15)),
    borderSide: const BorderSide(color: AppColors.primary),
  );
}

/// Animation constant
const defaultDuration = Duration(milliseconds: 250);
const kAnimationDuration = Duration(milliseconds: 200);