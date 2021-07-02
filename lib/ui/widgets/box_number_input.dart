import 'package:flutter/material.dart';
import 'package:fretto/ui/shared/colors.dart';

class BoxNumberInput extends StatefulWidget {
  final String? label;
  final int? initialValue;
  final Function(String? value)? onChanged;
  final FocusNode? focusNode;

  const BoxNumberInput(
      {Key? key,
      required this.label,
      required this.initialValue,
      required this.onChanged,
      this.focusNode})
      : super(key: key);
  @override
  _BoxNumberInputState createState() => _BoxNumberInputState();
}

class _BoxNumberInputState extends State<BoxNumberInput> {
  TextEditingController _controller = TextEditingController();
  final circularBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
  );
  @override
  void initState() {
    super.initState();
    _controller.text = widget.initialValue
        .toString(); // Setting the initial value for the field.
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: TextAlign.center,
      controller: _controller,
      style: TextStyle(
        height: 1,
      ),
      focusNode: widget.focusNode,
      readOnly: true,
      decoration: InputDecoration(
        labelText: widget.label,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        filled: true,
        fillColor: kcVeryLightGreyColor,
        prefixIcon: IconButton(
            icon: Icon(Icons.remove_outlined),
            onPressed: () {
              int currentValue = int.parse(_controller.text);
              currentValue--;
              if (widget.onChanged != null) {
                widget.onChanged!(currentValue.toString());
              }
              setState(() {
                _controller.text = (currentValue > 0 ? currentValue : 0)
                    .toString(); // decrementing value
              });
            }),
        suffixIcon: IconButton(
            icon: Icon(Icons.add_outlined),
            onPressed: () {
              int currentValue = int.parse(_controller.text);
              currentValue++;
              if (widget.onChanged != null) {
                widget.onChanged!(currentValue.toString());
              }
              setState(() {
                _controller.text =
                    (currentValue).toString(); // incrementing value
              });
            }),
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
    );
  }
}
