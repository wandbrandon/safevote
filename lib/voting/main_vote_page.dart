import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:safevoting/authentication_service.dart';

class MainVotingPage extends StatefulWidget {
  @override
  _MainVotingPageState createState() => _MainVotingPageState();
}

class _MainVotingPageState extends State<MainVotingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                icon: Icon(Icons.person_remove),
                onPressed: () async {
                  await context.read<AuthenticationService>().signOut();
                })
          ],
          title: Text('Elections'),
        ),
        body: ListView.builder(itemBuilder: (context, index) {
          return ListTile(
            title: Text('Election ' + index.toString()),
            onTap: () {},
            leading: Icon(Icons.account_balance_outlined),
            hoverColor: Colors.orange[100],
          );
        }));
  }
}
