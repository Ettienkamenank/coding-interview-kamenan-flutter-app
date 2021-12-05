import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:coding_interview_flutter_app/src/app/config/app_screen_size.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({
    Key? key,
    required this.boxHeight,
    required this.loaderSize,
    required this.loaderColor,
    required this.isCircular,
  }) : super(key: key);

  final double boxHeight, loaderSize;
  final Color loaderColor;
  final bool isCircular;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppScreenSize.height! * boxHeight,
      width: double.infinity,
      child: isCircular
          ? Center(
              child: SpinKitCircle(
                color: loaderColor,
                size: loaderSize,
              ),
            )
          : Center(
              child: SpinKitThreeBounce(
                color: loaderColor,
                size: loaderSize,
              ),
            ),
    );
  }
}
