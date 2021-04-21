import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:safevote/models/election_model.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';

class FirestoreService {
  final FirebaseFirestore db;

  FirestoreService(this.db);

  Future<void> createElection(Election election) async {
    CollectionReference elections = db.collection('elections');
    elections
        .doc(election.eid)
        .set(election.toJson())
        .then((value) => print("Election added"))
        .catchError((error) => print("Failed to add election: $error"));
  }

  Future<List<Election>>? getAllElections() {
    CollectionReference elections = db.collection('election');
    return elections.orderBy('elecend', descending: true).get().then(
        (qs) => qs.docs.map((e) => Election.fromJson(e.data()!)).toList());
  }

  Future<Map<String, dynamic>?> getElectionResults(String eid) async {
    var skey = utf8.encode('ANDREWBRANDONDANIELKENNETH');
    var bytes = utf8.encode("$eid");
    var hmacSha256 = Hmac(sha256, skey);
    var digest = hmacSha256.convert(bytes);
    print("HMAC digest as hex string: $digest");
    final response = await http.get(Uri.http(
        'ec2-34-232-76-7.compute-1.amazonaws.com/calculateelection',
        '/$eid/$digest'));
    if (response.statusCode != 200) {
      print('fail');
      throw Exception(
          'Oops, there was an error with our blockchain, errorcode: ${response.statusCode}');
    }
    print(response.body.toString());
    CollectionReference electionresults = db.collection('elecresults');
    Map<String, dynamic>? results =
        (await electionresults.doc(eid).get()).data();

    return results;
  }

  Future<void> vote(String uid, String eid, String vote) async {
    var skey = utf8.encode('ANDREWBRANDONDANIELKENNETH');
    var bytes = utf8.encode("$eid$uid$vote");
    var hmacSha256 = Hmac(sha256, skey);
    var digest = hmacSha256.convert(bytes);
    print("HMAC digest as hex string: $digest");
    final response = await http.get(Uri.http(
        'ec2-34-232-76-7.compute-1.amazonaws.com/addvote',
        '/$eid/$uid/$vote/$digest'));
    if (response.statusCode != 200) {
      print('fail');
      throw Exception(
          'Oops, there was an error with our blockchain, errorcode: ${response.statusCode}');
    }
    CollectionReference electionresults = db.collection('elecresults');
    electionresults
        .doc(eid)
        .set({
          'results': {uid: vote}
        })
        .then((value) => print("Election results added"))
        .catchError((error) => print("Failed to add election results: $error"));
  }

  Future<bool> hasVoted(String uid, String eid) async {
    CollectionReference electionresults = db.collection('elecresults');
    Map<String, dynamic>? results =
        (await electionresults.doc(eid).get()).data();
    if (results == null) {
      return false;
    }
    return results['results'].containsKey(uid);
  }
}
