import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('SafeVote'),
        ),
        body: Center(
            child: Container(
          width: 400,
          height: 300,
          child: Form(
            key: ValueKey('form1'),
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                ),
                SizedBox(
                  height: 30,
                ),
                OutlinedButton(
                    onPressed: () {
                      //TODO: Implement Sign in.
                      Navigator.pushNamed(context, '/main_vote');
                    },
                    child: Text('Sign In/Register'))
              ],
            ),
          ),
        )));
  }
}
