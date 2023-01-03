


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputOtp extends StatelessWidget {
  const InputOtp({Key? key, required this.controller, required this.textHint, required this.onEvent}): super(key: key);

  final TextEditingController controller;
  final String textHint;
  final Function onEvent;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 68,
      width: 64,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: textHint,
        ),
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          } else if (value.isEmpty) {
            FocusScope.of(context).previousFocus();
          }
          onEvent();
        },
        style: Theme.of(context).textTheme.headline6,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
      ),
    );
  }
}