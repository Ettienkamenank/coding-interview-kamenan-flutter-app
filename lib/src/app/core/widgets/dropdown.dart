import 'package:coding_interview_flutter_app/src/app/config/app_colors.dart';
import 'package:flutter/material.dart';

class CustomDropDown extends StatelessWidget {
  final Object? value;
  final String? hint, errorText;
  final List<DropdownMenuItem<Object>> items;
  final void Function(dynamic)?  onChanged;

  const CustomDropDown({
    Key? key,
    this.value,
    this.hint,
    required this.items,
    required this.onChanged,
    this.errorText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 30, vertical: .5),
                // const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
            child: DropdownButton<Object>(
              value: value,
              hint: Text(
                hint!,
                style: TextStyle(fontSize: 14),
                overflow: TextOverflow.ellipsis,
              ),
              style: TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 14,
                color: AppColors.black,
                fontWeight: FontWeight.bold,
              ),
              items: items,
              onChanged: onChanged,
              isExpanded: true,
              underline: Container(),
              icon: Icon(Icons.keyboard_arrow_down),
            ),
          ),
        ),
        if (errorText != null)
          Padding(
            padding: EdgeInsets.only(left: 30, top: 10),
            child: Text(
              errorText!,
              style: TextStyle(fontSize: 12, color: Colors.red[800]),
            ),
          )
      ],
    );
  }
}
