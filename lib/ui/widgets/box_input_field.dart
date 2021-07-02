import 'package:flutter/material.dart';
import 'package:fretto/ui/shared/colors.dart';

class BoxInputField extends StatelessWidget {
  final TextEditingController controller;
  final String placeholder;
  final Widget? leading;
  final Widget? trailing;
  final bool password;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final FocusNode? focusNode;
  final Function(String?)? onFieldSubmitted;
  final Function()? onTap;
  final void Function()? trailingTapped;
  final String? Function(String?)? validator;
  final String? label;
  final int? maxLines;
  final circularBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
  );

  BoxInputField(
      {Key? key,
      required this.controller,
      this.placeholder = '',
      this.leading,
      this.trailing,
      this.trailingTapped,
      this.password = false,
      this.keyboardType = TextInputType.text,
      this.textInputAction = TextInputAction.next,
      this.focusNode,
      this.validator,
      this.onFieldSubmitted,
      this.onTap,
      this.label,
      this.maxLines = 1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      style: TextStyle(height: 1),
      obscureText: password,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      focusNode: focusNode,
      onTap: onTap,
      readOnly: onTap != null,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        hintText: placeholder,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        filled: true,
        fillColor: kcVeryLightGreyColor,
        prefixIcon: leading,
        suffixIcon: trailing != null
            ? GestureDetector(
                onTap: trailingTapped,
                child: trailing,
              )
            : null,
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
      onFieldSubmitted: onFieldSubmitted,
    );
  }
}
