import 'package:flutter/material.dart';
import 'package:get_active_prf/custom_icons/google_icon_icons.dart';
import 'package:get_active_prf/screens/register.dart';
import 'package:get_active_prf/services/auth.dart';
import 'package:get_active_prf/styles/decorations.dart';
import 'package:page_transition/page_transition.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  AuthService auth = AuthService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _resetEmailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _resetEmailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: Color(0xfff4f4f4),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26.0),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 50),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                child: Register(),
                                type: PageTransitionType.leftToRight));
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'mija',
                            color: Colors.black.withOpacity(0.2)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Log in',
                          style: TextStyle(fontSize: 36, fontFamily: 'mija'),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      TextFormField(
                        controller: _emailController,
                        decoration: inputdecoration,
                        keyboardType: TextInputType.emailAddress,
                        validator: EmailValidator.validate,
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      TextFormField(
                          validator: PasswordValidator.validate,
                          controller: _passwordController,
                          obscureText: true,
                          decoration:
                              inputdecoration.copyWith(labelText: 'Password')),
                      SizedBox(
                        height: 5.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextFormField(
                                        controller: _resetEmailController,
                                        decoration: inputdecoration,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        validator: EmailValidator.validate,
                                      ),
                                      SizedBox(
                                        height: 11,
                                      ),
                                      LRbutton(
                                        title: 'Send E-mail',
                                        onpressedfunc: () async {
                                          try {
                                            await auth.sendPasswordResetEmail(
                                                _resetEmailController.text);
                                          } catch (e) {
                                            return showDialog(
                                                context: context,
                                                builder: (context) {
                                                  Future.delayed(
                                                      Duration(seconds: 23),
                                                      () {
                                                    Navigator.of(context)
                                                        .pop(true);
                                                  });
                                                  return AlertDialog(
                                                    title: Text(
                                                      'Try with a correct e-mail',
                                                      style: TextStyle(
                                                          fontFamily: 'mija',
                                                          fontSize: 16),
                                                    ),
                                                  );
                                                });
                                          }
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  ),
                                );
                              });
                        },
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            'forgot?',
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.6),
                                fontFamily: 'mija',
                                fontSize: 16),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      LRbutton(
                        onpressedfunc: () async {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Center(
                                  child: CircularProgressIndicator(
                                      valueColor:
                                          new AlwaysStoppedAnimation<Color>(
                                              Colors.white)),
                                );
                              });
                          try {
                            await auth.signInWithEmailAndPassword(
                                _emailController.text,
                                _passwordController.text);
                          } catch (e) {
                            print('$e');
                            showDialog(
                                context: context,
                                builder: (context) {
                                  Future.delayed(Duration(seconds: 4), () {
                                    Navigator.of(context).pop(true);
                                  });
                                  return AlertDialog(
                                    title: Text(
                                      'Try again with correct e-mail and password! ',
                                      style: TextStyle(
                                          fontFamily: 'mija', fontSize: 16),
                                    ),
                                  );
                                });
                          }
                          auth.setuserprogress();
                          auth.getUserProgress();
                          Navigator.pushNamed(context, '/Explore');
                        },
                        title: 'log in',
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      Center(
                        child: Text(
                          'Or log in with google account',
                          style: TextStyle(
                              fontSize: 19,
                              fontFamily: 'mija',
                              color: Colors.black),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: 165,
                          height: 45,
                          child: OutlineButton(
                            borderSide: BorderSide(
                                color: Colors.black.withOpacity(0.7), width: 2),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                children: [
                                  Icon(
                                    GoogleIcon.icons8_google,
                                    size: 16,
                                  ),
                                  SizedBox(width: 11),
                                  Text(
                                    'Google',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'mija',
                                        color: Colors.black),
                                  )
                                ],
                              ),
                            ),
                            onPressed: () async {
                              try {
                                await auth.signInWithGoogle();
                              } catch (e) {
                                print('$e');
                              }
                            },
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(90.0)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LRbutton extends StatelessWidget {
  final Function onpressedfunc;
  final String title;
  LRbutton({this.onpressedfunc, this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(boxShadow: <BoxShadow>[
          BoxShadow(
              offset: Offset(6, 9),
              color: Colors.grey.withOpacity(0.9),
              spreadRadius: 5.0,
              blurRadius: 14.0),
        ], borderRadius: BorderRadius.circular(40)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: RaisedButton(
            color: Color(0xff000000),
            child: Center(
              child: Text(
                '$title',
                style: TextStyle(
                  fontFamily: 'mija',
                  color: Color(0xfff4f4f4),
                ),
              ),
            ),
            onPressed: onpressedfunc,
          ),
        ),
      ),
    );
  }
}
