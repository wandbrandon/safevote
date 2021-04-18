//Forgot Password Page
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safevote/services/authentication_service.dart';
import 'package:flutter/animation.dart';
import 'package:safevote/login/email_sent.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String email = "";
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text('Create New Password'),
          ),
        ),
        body: Center(
            child: Container(
                alignment: Alignment.center,
                width: 400,
                height: 350,
                child: Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(children: [
                      new Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(15.0),
                        padding: const EdgeInsets.all(3.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: Text(
                            '*To reset your password, enter your accounts'
                            ''
                            's associated UFL email, then wait for a confirmation email at that address.',
                            style: TextStyle(fontStyle: FontStyle.italic)),
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
                      OutlinedButton(
                        onPressed: () async {
                          auth.sendPasswordResetEmail(email: email);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EmailSent()));
                        },
                        child: Text('Send Reset Password Email'),
                      ),
                    ])))));
  }
}
