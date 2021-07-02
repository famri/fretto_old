import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumberInput extends StatefulWidget {
  final String? inputLabel;
  final int? initialValue;
  final Function(String? value)? onChanged;

  const NumberInput(
      {Key? key,
      @required this.inputLabel,
      @required this.initialValue,
      @required this.onChanged})
      : super(key: key);
  @override
  _NumberInputState createState() => _NumberInputState();
}

class _NumberInputState extends State<NumberInput> {
  TextEditingController _controller = TextEditingController();

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
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          IconButton(
              icon: Icon(Icons.remove_outlined),
              onPressed: () {
                int currentValue = int.parse(_controller.text);
                setState(() {
                  currentValue--;
                  _controller.text = (currentValue > 0 ? currentValue : 0)
                      .toString(); // decrementing value
                });
              }),
          Expanded(
            child: TextFormField(
              onChanged: widget.onChanged,
              textAlign: TextAlign.center,
              controller: _controller,
              decoration: InputDecoration(
                labelText: widget.inputLabel,
                labelStyle:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
                prefixIcon: const Icon(Icons.person, color: Colors.lightBlue),
              ),
              keyboardType: TextInputType.numberWithOptions(
                decimal: false,
                signed: true,
              ),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
          ),
          IconButton(
              icon: Icon(Icons.add_outlined),
              onPressed: () {
                int currentValue = int.parse(_controller.text);
                setState(() {
                  currentValue++;
                  _controller.text =
                      (currentValue).toString(); // incrementing value
                });
              }),
        ],
      ),
    );
  }
}
