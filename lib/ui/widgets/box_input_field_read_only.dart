import 'package:flutter/material.dart';
import 'package:fretto/ui/shared/colors.dart';

class BoxInputFieldReadOnly extends StatelessWidget {
  final String? initialValue;
  final circularBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
  );

  BoxInputFieldReadOnly({
    this.initialValue,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      readOnly: true,
      style: TextStyle(height: 1),
      decoration: InputDecoration(
        //hintText: placeholder,
        enabled: false,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        filled: true,
        fillColor: kcVeryLightGreyColor,

        border: circularBorder.copyWith(
          borderSide: BorderSide(color: kcLightGreyColor),
        ),
      ),
    );
  }
}
