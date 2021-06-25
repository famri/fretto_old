import 'package:flutter/material.dart';
import 'package:fretto/ui/shared/colors.dart';
import 'package:fretto/ui/shared/styles.dart';

class BoxDropDownButtonField extends StatelessWidget {
  final int value;
  final List<DropdownMenuItemElement> elements;

  final void Function(int? value)? onChanged;

  final circularBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
  );

  BoxDropDownButtonField(
      {Key? key,
      required this.value,
      required this.elements,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<int>(
      decoration: InputDecoration(
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
          borderSide: BorderSide(color: kcPrimaryColor),
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
                  if (element.imagePath != null)
                    SizedBox(
                        width: 25,
                        height: 25,
                        child: Image.network(
                          element.imagePath!,
                          fit: BoxFit.contain,
                        )),
                ],
              ),
              value: element.value))
          .toList(),
      onChanged: onChanged,
      isExpanded: true,
    );
  }
}

class DropdownMenuItemElement {
  final String title;
  final int value;
  final String? imagePath;

  DropdownMenuItemElement(
      {required this.title, required this.value, this.imagePath});
}
