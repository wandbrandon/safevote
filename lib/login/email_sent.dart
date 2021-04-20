//Back to Login Page
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safevote/services/authentication_service.dart';
import 'package:safevote/login/login.dart';

class EmailSent extends StatefulWidget {
  @override
  _EmailSentState createState() => _EmailSentState();
}

class _EmailSentState extends State<EmailSent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Return to Login'),
        ),
        body: Container(
            width: 1500,
            height: 1500,
            color: Colors.grey[200],
            child: Column(
              children: [
                Container(
                  child: Image.network(
                      'https://media.giphy.com/media/x6q2SEFflggiQ/giphy.gif'),
                  width: 800,
                  height: 500,
                ),
                Text(
                    'The email has been sent. Please wait a few moments for it to arrive, or try again if it does not appear.\n'),
                OutlinedButton(
                    onPressed: () async {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    child: Text('Login'))
              ],
            )));
  }
}
