import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:provider/provider.dart';
import 'package:safevote/models/election_model.dart';
import 'package:safevote/services/firestore_service.dart';
import 'package:tap_builder/tap_builder.dart';

class VotingPage extends StatefulWidget {
  final Election election;

  const VotingPage({Key? key, required this.election}) : super(key: key);

  @override
  _VotingPageState createState() => _VotingPageState();
}

class _VotingPageState extends State<VotingPage> {
  Widget results(Map<String, dynamic?> results) {
    Map<String, int> candidateVotes = {};
    results.forEach((key, value) {
      if (candidateVotes[value] != null) {
        candidateVotes[value] = candidateVotes[value]! + 1;
      } else {
        candidateVotes[value] = 1;
      }
    });
    return Center(
      child: Padding(
          padding: const EdgeInsets.all(24),
          child: Container(child: Text(candidateVotes.toString()))),
    );
  }

  Widget votingBuilder() {
    if (widget.election.elecend.isBefore(DateTime.now())) {
      return FutureBuilder(
          future: context
              .watch<FirestoreService>()
              .getElectionResults(widget.election.eid),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Text('There was an error');
              case ConnectionState.waiting:
                return SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(),
                );
              case ConnectionState.active:
                return SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(),
                );
              case ConnectionState.done:
                print(snapshot.data);
                final elecresults = snapshot.data! as Map<String, dynamic?>;

                return results(elecresults['results']);
            }
          });
    } else {
      return Padding(
        padding: const EdgeInsets.only(bottom: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: GridView.builder(
                itemCount: widget.election.candidates.length,
                padding: EdgeInsets.all(32),
                itemBuilder: (context, index) => VoteCard(
                    eid: widget.election.eid,
                    name: widget.election.candidates[index],
                    color: Colors.primaries[index]),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    crossAxisSpacing: 32,
                    mainAxisSpacing: 32,
                    childAspectRatio: 1,
                    maxCrossAxisExtent: 500),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('This election will end in '),
                  CountdownTimer(
                    endTime: widget.election.elecend.millisecondsSinceEpoch,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.election.name),
        ),
        body: Center(
          child: FutureBuilder(
              future: context
                  .watch<FirestoreService>()
                  .hasVoted(context.watch<User?>()!.uid, widget.election.eid),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return SizedBox(
                      height: 50,
                      width: 50,
                      child: CircularProgressIndicator(),
                    );
                  case ConnectionState.done:
                    if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    }
                    if (snapshot.data == true &&
                        !widget.election.elecend.isBefore(DateTime.now())) {
                      return Center(
                        child: Text('Your vote has already been submitted'),
                      );
                    } else {
                      return votingBuilder();
                    }
                  case ConnectionState.none:
                    return Text('Something went wrong, try again.');
                  case ConnectionState.active:
                    return SizedBox(
                      height: 50,
                      width: 50,
                      child: CircularProgressIndicator(),
                    );
                }
              }),
        ));
  }
}

class VoteCard extends StatelessWidget {
  final String name;
  final Color color;
  final String eid;
  const VoteCard(
      {Key? key, required this.name, required this.color, required this.eid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedTapBuilder(onTap: () {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                actions: [
                  TextButton(
                    onPressed: () async {
                      await context
                          .read<FirestoreService>()
                          .vote(context.read<User?>()!.uid, eid, name);
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: Text('Yes'),
                  ),
                  TextButton(
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                    child: Text('No'),
                  ),
                ],
                content: Text(
                    'Are you sure you want to vote for this candidate? You will not be able to change your vote.'),
              ));

      // context
      //     .read<FirestoreService>()
      //     .vote(context.read<User?>()!.uid, eid, name);
    }, builder: (context, state, cursorLocation, cursorAlignment) {
      cursorAlignment = state == TapState.hover
          ? Alignment(-cursorAlignment.x, -cursorAlignment.y)
          : Alignment.center;
      return AnimatedContainer(
        transformAlignment: Alignment.center,
        transform: Matrix4.rotationX(-cursorAlignment.y * 0.15)
          ..rotateY(cursorAlignment.x * 0.15)
          ..scale(
            state == TapState.hover ? 1 : .95,
          ),
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: color,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Stack(
            fit: StackFit.expand,
            children: [
              AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: state == TapState.pressed ? 0.6 : 0.8,
                  child: Icon(
                    Icons.person,
                    size: 90,
                    color: Colors.white,
                  )),
              Positioned(
                top: 30,
                left: 30,
                child: AnimatedContainer(
                  transformAlignment: Alignment.center,
                  transform: Matrix4.translationValues(
                    cursorAlignment.x * 3,
                    cursorAlignment.y * 3,
                    0,
                  ),
                  duration: const Duration(milliseconds: 200),
                  child: Text(
                    name,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: AnimatedAlign(
                  duration: const Duration(milliseconds: 200),
                  alignment: Alignment(-cursorAlignment.x, -cursorAlignment.y),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.01),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white
                              .withOpacity(state == TapState.hover ? 0.5 : 0.0),
                          blurRadius: 200,
                          spreadRadius: 130,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
