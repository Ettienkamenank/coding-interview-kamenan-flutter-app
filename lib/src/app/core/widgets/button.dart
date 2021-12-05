import 'package:coding_interview_flutter_app/src/app/config/app_colors.dart';
import 'package:coding_interview_flutter_app/src/app/config/app_constants.dart';
import 'package:coding_interview_flutter_app/src/app/config/app_screen_size.dart';
import 'package:flutter/material.dart';

class AppDefaultButton extends StatelessWidget {
  const AppDefaultButton({
    Key? key,
    required this.title,
    required this.backgroundColor,
    required this.textColor,
    required this.onPressed,
  }) : super(key: key);

  final String title;
  final Color backgroundColor, textColor;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: getScreenHeight(60),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: backgroundColor,
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: getScreenWidth(18),
            color: textColor,
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}

class AppMaterialButton extends StatelessWidget {
  const AppMaterialButton({
    Key? key,
    required this.title,
    required this.color,
    required this.minWidth,
    required this.borderRadius,
    required this.onPressed,
  }) : super(key: key);

  final String title;
  final Color color;
  final double minWidth, borderRadius;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      color: color,
      borderRadius: BorderRadius.circular(borderRadius),
      child: MaterialButton(
        onPressed: onPressed,
        minWidth: minWidth,
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        child: Text(
          title,
          style: kAppButtonTextStyle,
        ),
      ),
    );
  }
}

class AppButtonOnContainer extends StatelessWidget {
  const AppButtonOnContainer({
    Key? key,
    required this.title,
    required this.onTap,
    required this.marginTop,
  }) : super(key: key);

  final String title;
  final Function()? onTap;
  final double marginTop;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: AppScreenSize.height! * .065,
        alignment: Alignment.center,
        margin: EdgeInsets.only(left: 20, right: 20, top: marginTop),
        padding: const EdgeInsets.only(left: 20, right: 20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.primary, AppColors.primaryLight],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(50),
          color: Colors.grey[200],
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 10),
              blurRadius: 50,
              color: Color(0xFFEEEEEE),
            ),
          ],
        ),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
