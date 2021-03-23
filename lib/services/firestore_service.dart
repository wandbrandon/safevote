import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:safevoting/models/election_model.dart';

class FirestoreSerice {
  final FirebaseFirestore db;

  FirestoreSerice(this.db);

  Future<void> createElection(Election election) async {
    CollectionReference elections = db.collection('elections');
    elections
        .doc(election.eid)
        .set(election.toJson())
        .then((value) => print("Election added"))
        .catchError((error) => print("Failed to add election: $error"));
    CollectionReference electionsresult = db.collection('elecresults');
    electionsresult
        .doc(election.eid)
        .set({'results': null})
        .then((value) => print("Election results added"))
        .catchError((error) => print("Failed to add election results: $error"));
  }

  Future<List<Election>> getAllElections() {
    try {
      CollectionReference elections = db.collection('elections');
      return elections.orderBy('elecend', descending: true).get().then(
          (qs) => qs.docs.map((e) => Election.fromJson(e.data())).toList());
    } catch (e) {
      print('There was an error: $e');
    }

    return null;
  }

  Future<ElectionResults> getElectionResults(String eid) async {
    try {
      CollectionReference electionresults = db.collection('elecresults');
      return ElectionResults.fromJson(
          (await electionresults.doc(eid).get()).data());
    } on Exception catch (e) {
      print('There was an error: $e');
    }
    return null;
  }
}
