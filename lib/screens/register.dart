import 'package:flutter/material.dart';
import 'package:get_active_prf/styles/decorations.dart';
import 'package:get_active_prf/widgets/l_r_button.dart';

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: inputdecoration.copyWith(hintText: 'name'),
            ),
            SizedBox(
              height: 12.0,
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: inputdecoration.copyWith(hintText: 'Email'),
            ),
            SizedBox(
              height: 12.0,
            ),
            TextField(
              obscureText: true,
              decoration: inputdecoration.copyWith(hintText: 'password'),
            ),
            SizedBox(
              height: 12.0,
            ),
            TextField(
              obscureText: true,
              decoration:
                  inputdecoration.copyWith(hintText: 'Confirm password'),
            ),
            SizedBox(
              height: 14.0,
            ),
            LRButton(
              onPressed: () {},
              title: 'Register',
              width: 284.0,
            )
          ],
        ),
      ),
    );
  }
}
