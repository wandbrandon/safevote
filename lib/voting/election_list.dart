import 'dart:async';

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
  bool animate = true;
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
      participants: ['Barack Obama', 'Mitt Romney'],
    )
  ];
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      setState(() {
        animate = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Elections')),
          actions: [
            Tooltip(
              message: 'Administrator Access',
              child: IconButton(
                  icon: Icon(Icons.admin_panel_settings_outlined),
                  onPressed: () {
                    //Navigator.push(AdminPage)
                  }),
            ),
            Tooltip(
              message: 'Sign Out',
              child: IconButton(
                  icon: Icon(Icons.person_remove),
                  onPressed: () async {
                    await context.read<AuthenticationService>().signOut();
                  }),
            ),
          ],
        ),
        body: animate
            ? Container(
                alignment: Alignment.center,
                child: Image.network(
                    'data:image/png;base64,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'),
                height: 1500,
                width: 1500)
            : ListView.builder(
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
