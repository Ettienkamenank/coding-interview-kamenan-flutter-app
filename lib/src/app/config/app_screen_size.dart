import 'package:flutter/material.dart';

class AppScreenSize {
  static MediaQueryData _mediaQueryData = const MediaQueryData();
  static double? height;
  static double? width;

  static double? defaultSize;
  static Orientation orientation = Orientation as Orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    width = _mediaQueryData.size.width;
    height = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
  }

  static Size getSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

// /// Get the proportionate height as per screen size
// static double getScreenHeight(double inputHeight) {
//   double screenHeight = AppScreenSize.screenHeight!;
//   /// 812 is the layout height that designer use
//   return (inputHeight / 812.0) * screenHeight;
// }
//
// /// Get the proportionate height as per screen size
// static double getScreenWidth(double inputWidth) {
//   double screenWidth = AppScreenSize.screenWidth!;
//   /// 375 is the layout width that designer use
//   return (inputWidth / 375.0) * screenWidth;
// }

}

/// Get the proportionate height as per screen size
double getScreenHeight(double inputHeight) {
  double screenHeight = AppScreenSize.height!;

  /// 812 is the layout height that designer use
  return (inputHeight / 812.0) * screenHeight;
}

/// Get the proportionate height as per screen size
double getScreenWidth(double inputWidth) {
  double screenWidth = AppScreenSize.width!;

  /// 375 is the layout width that designer use
  return (inputWidth / 375.0) * screenWidth;
}
