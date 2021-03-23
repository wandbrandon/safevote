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
        'eid': eid ?? '',
        'elecend': elecend ?? '',
        'name': name ?? '',
        'participants': participants ?? ''
      };
}
