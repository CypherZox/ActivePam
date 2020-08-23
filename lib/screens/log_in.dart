import 'package:flutter/material.dart';
import 'package:get_active_prf/styles/decorations.dart';
import 'package:get_active_prf/widgets/l_r_button.dart';
import 'package:get_active_prf/widgets/log_in_google.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
              height: 14.0,
            ),
            LRButton(
              onPressed: () {},
              title: 'log in',
              width: 290.0,
            ),
            SizedBox(
              height: 9.0,
            ),
            GoogleSignIn(),
            SizedBox(
              height: 70.0,
            ),
            FlatButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/Register');
                },
                child: Text(
                  'Register!',
                  style: TextStyle(fontSize: 18, letterSpacing: 2.0),
                ))
          ],
        ),
      ),
    );
  }
}
