


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputOtp extends StatelessWidget {
  const InputOtp({Key? key}): super(key: key);


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 68,
      width: 64,
      child: TextField(
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