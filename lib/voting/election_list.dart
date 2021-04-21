import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:provider/provider.dart';
import 'package:safevote/models/election_model.dart';
import 'package:safevote/services/authentication_service.dart';
import 'package:safevote/services/firestore_service.dart';
import 'package:safevote/voting/vote_page.dart';

class ElectionList extends StatefulWidget {
  @override
  _ElectionListState createState() => _ElectionListState();
}

class _ElectionListState extends State<ElectionList> {
  @override
  Widget build(BuildContext context) {
    final elections = context.watch<List<Election>>();

    return elections.isNotEmpty
        ? Scaffold(
            appBar: AppBar(
              title: Text('Elections'),
            ),
            body: ListView.builder(
                itemCount: elections.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(elections[index].name),
                    onTap: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  VotingPage(election: elections[index])));
                    },
                    leading: Icon(Icons.account_balance_outlined),
                    trailing: CountdownTimer(
                      endTime: elections[index].elecend.millisecondsSinceEpoch,
                      endWidget: Text('Election is complete'),
                    ),
                    hoverColor: Colors.orange[100],
                  );
                }))
        : SizedBox(height: 30, width: 30, child: CircularProgressIndicator());
  }
}
