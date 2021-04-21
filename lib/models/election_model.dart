class Election {
  final String eid;
  final DateTime elecend;
  final String name;
  final List<dynamic> candidates;

  Election(
      {required this.eid,
      required this.elecend,
      required this.name,
      required this.candidates});

  Election.fromJson(Map<String, dynamic> data)
      : eid = data['eid'],
        elecend = DateTime.parse(data['elecend'].toDate().toString()),
        name = data['name'],
        candidates = data['candidates'];

  Map<String, dynamic> toJson() =>
      {'eid': eid, 'elecend': elecend, 'name': name, 'candidates': candidates};
}

class ElectionResults {
  final String eid;
  final Map<String, dynamic> results;

  ElectionResults({required this.eid, required this.results});

  ElectionResults.fromJson(Map<String, dynamic> data)
      : eid = data['eid'],
        results = data['results'];

  Map<String, dynamic> toJson() => {'eid': eid, 'results': results};
}
