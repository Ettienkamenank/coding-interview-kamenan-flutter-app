import 'package:bot_toast/bot_toast.dart';
import 'package:coding_interview_flutter_app/src/app/config/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void showAppNotification({
  String title = 'Notification',
  String message = 'Erreur inconnue !',
}) {
  BotToast.showCustomNotification(
      enableSlideOff: true,
      backButtonBehavior: BackButtonBehavior.none,
      crossPage: true,
      onlyOne: true,
      animationDuration: const Duration(milliseconds: 500),
      animationReverseDuration: const Duration(milliseconds: 300),
      duration: const Duration(seconds: 5),
      toastBuilder: (void Function() cancelFunc) {
        return Card(
          color: Colors.white.withOpacity(0.9),
          elevation: 10.0,
          shadowColor: AppColors.light,
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const FaIcon(
                  FontAwesomeIcons.info,
                  color: AppColors.icon,
                  size: 24,
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '$title\n',
                          style: const TextStyle(
                            fontSize: 18,
                            color: AppColors.icon,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: message,
                          style: const TextStyle(
                            height: 1.5,
                            color: Colors.black54,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.cancel,
                    color: AppColors.secondaryLight,
                  ),
                  onPressed: cancelFunc,
                ),
              ],
            ),
          ),
        );
      });
}
