

import 'package:flutter/material.dart';
import 'package:ourpass_assessment/utils/custom.colors.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              color: Colors.amber,
              width: double.infinity,
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Pass.Assessment",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: CustomColors.appColor,
                        fontSize: 28,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),

                  const SizedBox(height: 30.0,),

                  Text(
                    "Please login here.",
                    style: TextStyle(
                        color: CustomColors.textColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w300
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}