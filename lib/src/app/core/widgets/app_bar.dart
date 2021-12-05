import 'package:coding_interview_flutter_app/src/app/config/app_colors.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    this.title,
    required this.color,
    this.onTap,
    this.logout,
    this.showAction,
  }) : super(key: key);

  final String? title;
  final Color color;
  final void Function()? onTap, logout;
  final bool? showAction;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title == null
          ? const Text('')
          : Text(
              title!,
              style: const TextStyle(
                color: AppColors.primary,
              ),
            ),
      leading: GestureDetector(
        child: const Icon(
          Icons.arrow_back_ios,
          color: AppColors.primary,
        ),
        onTap: onTap,
      ),
      actions: showAction != null
          ? [
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: GestureDetector(
                  child: const Icon(
                    Icons.logout,
                    color: AppColors.primary,
                  ),
                  onTap: logout,
                ),
              ),
            ]
          : [],
      // foregroundColor: color,
      backgroundColor: color,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
