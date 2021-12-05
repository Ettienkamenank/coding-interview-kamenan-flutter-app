import 'package:flutter/material.dart';
import 'package:coding_interview_flutter_app/src/app/config/app_colors.dart';
import 'package:coding_interview_flutter_app/src/app/config/app_screen_size.dart';

class AppInputField extends StatefulWidget {
  const AppInputField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.labelText,
    this.validator,
    this.inputType = TextInputType.text,
    this.focusNode,
    this.onFinished,
    this.isPassword = false,
    this.isReadOnly = false,
    this.prefixIcon,
    this.suffixIcon,
    this.horizontalPadding = 16.0,
    this.onValueChanged,
    this.onEditingComplete,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText, labelText;
  final FormFieldValidator? validator;
  final TextInputType inputType;
  final FocusNode? focusNode;
  final VoidCallback? onFinished;
  final bool isPassword, isReadOnly;
  final IconData? prefixIcon, suffixIcon;
  final double horizontalPadding;
  final Function(String?)? onValueChanged;
  final Function()? onEditingComplete;

  @override
  State<AppInputField> createState() => AppInputFieldState();
}

class AppInputFieldState extends State<AppInputField> {
  String? error;
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          style: const TextStyle(
            fontSize: 17.0,
            color: AppColors.primaryLight,
          ),
          cursorColor: AppColors.primaryLight,
          textAlign: TextAlign.left,
          controller: widget.controller,
          onChanged: widget.onValueChanged,
          onEditingComplete: widget.onEditingComplete,
          focusNode: widget.focusNode,
          keyboardType: widget.inputType,
          obscureText: widget.isPassword,
          readOnly: widget.isReadOnly,
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 0, vertical: 18),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide:
                  const BorderSide(color: AppColors.secondaryLight, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide:
                  const BorderSide(color: AppColors.primaryLight, width: 1.5),
            ),
            // border: outlineInputBorder,
            labelText: widget.labelText,
            labelStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryLight,
            ),
            hintText: widget.hintText,
            hintStyle: const TextStyle(
              fontSize: 12,
              color: AppColors.secondaryLight,
            ),
            prefixIcon: Icon(
              widget.prefixIcon,
              color: AppColors.primaryLight,
            ),
            suffixIcon: Icon(
              widget.suffixIcon,
              color: AppColors.primaryLight,
            ),
          ),
        ),
        error != null
            ? Text(
                error.toString(),
                style: const TextStyle(
                    color: AppColors.secondaryLight, fontSize: 12),
              )
            : Container()
      ],
    );
  }

  String? validate() {
    if (widget.validator != null) {
      setState(() {
        error = widget.validator!(widget.controller.text);

        if (error == null) {
          isChecked = true;
        }
      });
    }

    return error;
  }

//END OF CLASS
}

class AppInputFieldOnContainer extends StatefulWidget {
  const AppInputFieldOnContainer({
    required Key key,
    required this.controller,
    required this.validator,
    this.focusNode,
    this.onTap,
    this.inputType = TextInputType.text,
    this.isPassword = false,
    this.isReadOnly = false,
    required this.hintText,
    required this.icon,
    required this.marginTop,
  }) : super(key: key);

  final TextEditingController controller;
  final FormFieldValidator validator;
  final FocusNode? focusNode;
  final Function()? onTap;
  final bool isPassword, isReadOnly;
  final TextInputType inputType;
  final String hintText;
  final IconData icon;
  final double marginTop;

  @override
  State<AppInputFieldOnContainer> createState() =>
      AppInputFieldOnContainerState();
}

class AppInputFieldOnContainerState extends State<AppInputFieldOnContainer> {
  String? error;
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: AppScreenSize.height! * .07,
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 20, right: 20, top: widget.marginTop),
          padding: const EdgeInsets.only(left: 20, right: 20),
          decoration: BoxDecoration(
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
          child: TextField(
            controller: widget.controller,
            keyboardType: widget.inputType,
            focusNode: widget.focusNode,
            onTap: widget.onTap,
            obscureText: widget.isPassword,
            readOnly: widget.isReadOnly,
            cursorColor: AppColors.primaryLight,
            decoration: InputDecoration(
              icon: Icon(widget.icon, color: AppColors.primaryLight),
              hintText: widget.hintText,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
        ),
        error != null
            ? Text(
                error.toString(),
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 13,
                ),
              )
            : Container(),
      ],
    );
  }

  String? validate() {
    setState(() {
      error = widget.validator(widget.controller.text);

      if (error == null) {
        isChecked = true;
      }
    });

    return error;
  }

//END OF CLASS
}
