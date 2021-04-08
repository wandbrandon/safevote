import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:safevote/services/authentication_service.dart';

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
            title: Text('Election ${index + 1}'),
            // VotePage() or a drop down with Candidates and Title?
            onTap: () {
              Row(children: <Widget>[
                Expanded(
                  child: Text("Election Title: "),
                ),
              ]);
            },
            leading: Icon(Icons.where_to_vote_outlined),
            hoverColor: Colors.orange[100],
          );
        }));
  }
}
