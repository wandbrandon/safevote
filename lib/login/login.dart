import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safevote/services/authentication_service.dart';
import 'package:flutter/animation.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = '';
  String psswrd = '';
  String confirmPassword = '';
  bool createAccount = false;
  bool forgotPass = false;
  bool nonMatchingPasswords = false;
  var nMP = TextEditingController();
  String badPasswords = '';

  bool doPasswordsMatch(String a, String b) {
    bool doTheyMatch = true;
    if (a != b) {
      doTheyMatch = false;
    }
    return doTheyMatch;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('SafeVote'),
        ),
        body: Center(
            child: AnimatedSwitcher(
          duration: Duration(milliseconds: 300),
          switchInCurve: Curves.ease,
          switchOutCurve: Curves.ease,
          child: !createAccount
              ? Container(
                  key: ValueKey('signin'),
                  width: 400,
                  height: 300,
                  child: Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: ValueKey('form1'),
                    child: Column(
                      children: [
                        TextFormField(
                          onChanged: (text) {
                            email = text;
                          },
                          decoration: InputDecoration(labelText: 'Email'),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          obscureText: true,
                          onChanged: (text) {
                            psswrd = text;
                          },
                          decoration: InputDecoration(labelText: 'Password'),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        OutlinedButton(
                            onPressed: () async {
                              await context
                                  .read<AuthenticationService>()
                                  .signIn(email: email, password: psswrd);
                            },
                            child: Text('Sign In')),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              OutlinedButton(
                                  onPressed: () async {
                                    setState(() {
                                      createAccount = !createAccount;
                                    });
                                  },
                                  child: Text('Create Account')),
                              OutlinedButton(
                                onPressed: () async {
                                  setState(() {
                                    forgotPass = !forgotPass;
                                  });
                                },
                                child: Text('Forgot Password?'),
                              )
                            ]),
                      ],
                    ),
                  ),
                )
              : Container(
                  key: ValueKey('create'),
                  width: 400,
                  height: 400,
                  child: Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: ValueKey('form2'),
                    child: Column(
                      children: [
                        Text(
                          badPasswords,
                        ),
                        TextFormField(
                          onChanged: (text) {
                            email = text;
                          },
                          decoration: InputDecoration(labelText: 'Email'),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          obscureText: true,
                          onChanged: (text) {
                            psswrd = text;
                          },
                          decoration: InputDecoration(labelText: 'Password'),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          onChanged: (text) {
                            confirmPassword = text;
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                              labelText: 'Confirm Password',
                              errorText:
                                  (doPasswordsMatch(psswrd, confirmPassword))
                                      ? null
                                      : 'Passwords dont match'),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        OutlinedButton(
                            onPressed: () async {
                              if (confirmPassword == psswrd) {
                                await context
                                    .read<AuthenticationService>()
                                    .signUp(email: email, password: psswrd);
                                //Fixed Auto Sign-In from Registration Page.
                                await context
                                    .read<AuthenticationService>()
                                    .signOut();
                              } else {
                                debugPrint("passwords dont match");
                              }
                            },
                            child: Text('Register')),
                        OutlinedButton(
                            onPressed: () async {
                              setState(() {
                                createAccount = !createAccount;
                              });
                            },
                            child: Text('Sign In?'))
                      ],
                    ),
                  ),
                ),
        )));
  }
}
