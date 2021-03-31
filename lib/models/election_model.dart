class Election {
  final String eid;
  final DateTime elecend;
  final String name;
  final List<String> participants;

  Election(this.eid, this.elecend, this.name, this.participants);

  Election.fromJson(Map<String, dynamic> data)
      : eid = data['eid'],
        elecend = data['name'],
        name = data['name'],
        participants = data['participants'];

  Map<String, dynamic> toJson() => {
        'eid': eid,
        'elecend': elecend,
        'name': name,
        'participants': participants
      };
}

class ElectionResults {
  final String eid;
  final Map<String, String> results;

  ElectionResults(this.eid, this.results);

  ElectionResults.fromJson(Map<String, dynamic> data)
      : eid = data['eid'],
        results = data['results'];

  Map<String, dynamic> toJson() => {'eid': eid, 'results': results};
}
