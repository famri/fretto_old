import 'package:flutter/material.dart';
import 'package:fretto/ui/shared/colors.dart';

class BoxDropDownButtonField extends StatelessWidget {
  final int? value;
  final List<DropdownMenuItemElement> elements;

  final void Function(int? value)? onChanged;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final String? hintText;
  final String? label;
  final String? Function(int? value)? validator;

  final circularBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
  );

  BoxDropDownButtonField(
      {Key? key,
      required this.value,
      required this.elements,
      required this.onChanged,
      this.focusNode,
      this.nextFocusNode,
      this.hintText,
      this.label,
      this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<int>(
      focusNode: focusNode,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        //isDense: true,
        contentPadding: const EdgeInsets.all(12.5),
        filled: true,
        fillColor: kcVeryLightGreyColor,
        hintText: hintText,
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
      ),
      value: value,
      items: elements
          .map<DropdownMenuItem<int>>((element) => DropdownMenuItem<int>(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    element.title,
                    style: TextStyle(height: 1),
                  ),
                  if (element.trailing != null) element.trailing!
                ],
              ),
              value: element.value))
          .toList(),
      onChanged: (value) {
        if (nextFocusNode != null) {
          FocusScope.of(context).requestFocus(nextFocusNode);
        }
        if (onChanged != null) {
          onChanged!(value);
        }
      },
      isExpanded: true,
    );
  }
}

class DropdownMenuItemElement {
  final String title;
  final int value;
  final Widget? trailing;

  DropdownMenuItemElement(
      {required this.title, required this.value, this.trailing});
}
