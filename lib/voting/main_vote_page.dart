import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MainVotingPage extends StatefulWidget {
  @override
  _MainVotingPageState createState() => _MainVotingPageState();
}

class _MainVotingPageState extends State<MainVotingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Elections'),
        ),
        body: ListView.builder(itemBuilder: (context, index) {
          return ListTile(
            title: Text('Election ' + index.toString()),
            onTap: () {
              //TODO: Choose election
            },
            leading: Icon(Icons.account_balance_outlined),
            hoverColor: Colors.orange[100],
          );
        }));
  }
}
