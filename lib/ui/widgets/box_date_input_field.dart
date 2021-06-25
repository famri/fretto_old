import 'package:flutter/material.dart';
import 'package:fretto/ui/shared/colors.dart';
import 'package:intl/intl.dart';

class BoxDateInputField extends StatelessWidget {
  final TextEditingController controller;
  final String placeholder;
  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final FocusNode? focusNode;
  final bool requestNextFocus;

  final String? Function(String?)? validator;

  final DateFormat _dateFormatter = DateFormat.yMd();

  final circularBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
  );

  BoxDateInputField(
      {Key? key,
      required this.controller,
      this.placeholder = '',
      required this.initialDate,
      required this.firstDate,
      required this.lastDate,
      this.focusNode,
      this.requestNextFocus = false,
      this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      onTap: () => _showDatePicker(context),
      controller: controller,
      validator: validator,
      style: TextStyle(height: 1),
      focusNode: focusNode,
      decoration: InputDecoration(
        hintText: placeholder,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        filled: true,
        fillColor: kcVeryLightGreyColor,

        border: circularBorder.copyWith(
          borderSide: BorderSide(color: kcLightGreyColor),
        ),
        errorBorder: circularBorder.copyWith(
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedBorder: circularBorder.copyWith(
          borderSide: BorderSide(color: kcAccentColor),
        ),
        enabledBorder: circularBorder.copyWith(
          borderSide: BorderSide(color: kcLightGreyColor),
        ),
        // filled: true,
        // fillColor: kcVeryLightGreyColor,
      ),
    );
  }

  void _showDatePicker(BuildContext context) async {
    await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      initialDatePickerMode: DatePickerMode.year,
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      if (requestNextFocus) {
        FocusScope.of(context).nextFocus();
      }

      controller.text = _dateFormatter.format(pickedDate);
    });
  }
}
