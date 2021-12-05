import 'package:flutter/material.dart';
import 'package:coding_interview_flutter_app/src/app/config/app_colors.dart';
import 'package:coding_interview_flutter_app/src/app/config/app_screen_size.dart';

Future openBottomModal({
  required BuildContext context,
  required Widget child,
  required Color color,
  void Function()? onTap,
}) {
  return showModalBottomSheet(
    backgroundColor: Colors.transparent,
    isDismissible: false,
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return Container(
        height: AppScreenSize.height! * .5,
        width: double.infinity,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: color,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            child,
            GestureDetector(
              child: const Text(
                'Fermer',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 18,
                ),
              ),
              onTap: onTap,
            ),
          ],
        ),
      );
    },
  );
}

SnackBar customSnackBar({
  required String message,
  required double radius,
  Color? color,
}) {
  return SnackBar(
    content: Text(
      message,
      style: const TextStyle(
        fontSize: 16,
      ),
    ),
    backgroundColor: color ?? AppColors.primary,
    behavior: SnackBarBehavior.floating,
    duration: const Duration(seconds: 3),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
    ),
  );
}
