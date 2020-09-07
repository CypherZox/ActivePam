import 'package:flutter/material.dart';
import 'package:get_active_prf/styles/decorations.dart';
import 'package:get_active_prf/widgets/l_r_button.dart';
import 'package:get_active_prf/widgets/log_in_google.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _success;
  String _userEmail;
  String email;
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      print('eroor occures $e');
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: inputdecoration.copyWith(hintText: 'Email'),
              ),
              SizedBox(
                height: 12.0,
              ),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: inputdecoration.copyWith(hintText: 'password'),
              ),
              SizedBox(
                height: 14.0,
              ),
              LRButton(
                onPressed: () async {
                  try {
                    _signInWithEmailAndPassword();
                  } catch (e) {
                    print('$e');
                  }
                  Navigator.pushNamed(context, '/Explore');
                  // if (_success) {
                  //   Navigator.pushNamed(context, '/Explore');
                  //   print('succeeded');
                  // }
                },
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
                  )),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  _success == null
                      ? ''
                      : (_success
                          ? 'Successfully signed in ' + _userEmail
                          : 'Sign in failed'),
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _signInWithEmailAndPassword() async {
    final User user = (await _auth.signInWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    ))
        .user;

    if (user != null) {
      setState(() {
        _success = true;
        _userEmail = user.email;
      });
    } else {
      setState(() {
        _success = true;
      });
    }
  }
}
