import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:safevote/models/election_model.dart';
import 'package:safevote/services/authentication_service.dart';
import 'package:safevote/voting/vote_page.dart';

class ElectionList extends StatefulWidget {
  @override
  _ElectionListState createState() => _ElectionListState();
}

class _ElectionListState extends State<ElectionList> {
  List<Election> elections = [
    Election(
      eid: '910829184023',
      name: 'Presidential Election 2020',
      elecend: DateTime(2021, 5, 1, 17, 30),
      participants: ['Donald Trump', 'Hillary Clinton'],
    ),
    Election(
      eid: 'sfwef829184023',
      name: 'Presidential Election 2012',
      elecend: DateTime(2021, 7, 1, 17, 30),
      participants: ['Barack Obama', 'Hillary Clinton'],
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Elections'),
        ),
        body: ListView.builder(
            itemCount: elections.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(elections[index].name),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              VotingPage(election: elections[index])));
                },
                leading: Icon(Icons.account_balance_outlined),
                hoverColor: Colors.orange[100],
              );
            }));
  }
}
