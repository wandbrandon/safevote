import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:safevote/models/election_model.dart';
import 'package:tap_builder/tap_builder.dart';

class VotingPage extends StatefulWidget {
  final Election election;

  const VotingPage({Key? key, required this.election}) : super(key: key);

  @override
  _VotingPageState createState() => _VotingPageState();
}

class _VotingPageState extends State<VotingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.election.name),
        ),
        body: Padding(
          padding: const EdgeInsets.only(bottom: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: GridView.builder(
                  itemCount: widget.election.participants.length,
                  padding: EdgeInsets.all(32),
                  itemBuilder: (context, index) => VoteCard(
                      image: index == 0 ? 'images/DT.png' : 'images/HC.png',
                      name: widget.election.participants[index],
                      color: index == 0 ? Colors.red : Colors.blue),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      crossAxisSpacing: 32,
                      mainAxisSpacing: 32,
                      maxCrossAxisExtent: 1000),
                ),
              ),
              Text('This election will end in '),
              CountdownTimer(
                endTime: widget.election.elecend.millisecondsSinceEpoch,
              ),
            ],
          ),
        ));
  }
}

class VoteCard extends StatelessWidget {
  final String name;
  final String image;
  final Color color;
  const VoteCard(
      {Key? key, required this.name, required this.color, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedTapBuilder(
        onTap: () {},
        builder: (context, state, cursorLocation, cursorAlignment) {
          cursorAlignment = state == TapState.hover
              ? Alignment(-cursorAlignment.x, -cursorAlignment.y)
              : Alignment.center;
          return AnimatedContainer(
            height: 200,
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
                      child: Image.asset(
                        '$image',
                        fit: BoxFit.cover,
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
                      alignment:
                          Alignment(-cursorAlignment.x, -cursorAlignment.y),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.01),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(
                                  state == TapState.pressed ? 0.5 : 0.0),
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
