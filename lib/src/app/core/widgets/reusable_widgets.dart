import 'package:flutter/material.dart';
import 'package:coding_interview_flutter_app/src/app/config/app_colors.dart';
import 'package:coding_interview_flutter_app/src/app/config/app_screen_size.dart';

Widget buildAuthenticationLogoCard({required String message}) {
  return Container(
    height: AppScreenSize.height! * .38,
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(90),
      ),
      gradient: LinearGradient(
        colors: [AppColors.primary, AppColors.primaryLight],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    ),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 50),
            // child: Image.asset(
            //   AppFiles.logo,
            //   fit: BoxFit.cover,
            //   height: getScreenWidth(100),
            // ),
            child: FlutterLogo(size: getScreenWidth(100)),
          ),
          Container(
            margin: const EdgeInsets.only(right: 20, top: 20),
            alignment: Alignment.bottomRight,
            child: Text(
              message,
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
          )
        ],
      ),
    ),
  );
}

Widget buildGoToNextPageRow({
  required String question,
  required String action,
  Function()? onTap,
}) {
  return Container(
    margin: const EdgeInsets.only(top: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          question,
          style: const TextStyle(fontSize: 15),
        ),
        GestureDetector(
          child: Text(
            action,
            style: const TextStyle(
              color: AppColors.grey,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: onTap,
        ),
      ],
    ),
  );
}

Widget buildCheckBoxOnContainer({
  required String title,
  required bool value,
  required Function(bool?)? onChanged,
}) {
  return SizedBox(
    width: AppScreenSize.width! * .4,
    child: CheckboxListTile(
      title: Text(title, style: const TextStyle(fontSize: 17)),
      activeColor: AppColors.primaryLight,
      controlAffinity: ListTileControlAffinity.leading,
      value: value,
      onChanged: onChanged,
    ),
  );
}
