class Vessel {
  final int? id;
  final String vesselName;
  final String place;
  final String flag;
  final String IMO;
  final String portRegistry;
  //final DateTime dateBuilding;
  //final VesselType vesselType;
  final String owner;
  final String operator;
  final String? imageUrl;

  Vessel({
    this.id,
    required this.vesselName,
    required this.place,
    required this.portRegistry,
    required this.owner,
    required this.flag,
    required this.IMO,
    required this.operator,
    this.imageUrl,
  });

  factory Vessel.fromMap(Map<String, dynamic> map) {
    return Vessel(
      id: map['id'],
      vesselName: map['vesselName'] ?? '',
      place: map['place'] ?? '',
      portRegistry: map['portRegistry'] ?? '',
      owner: map['owner'] ?? '',
      flag: map['flag'] ?? '',
      IMO: map['IMO'] ?? '',
      operator: map['operator'] ?? '',
      imageUrl: map['imageUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'vesselName': vesselName,
      'place': place,
      'portRegistry': portRegistry,
      'owner': owner,
      'flag': flag,
      'IMO': IMO,
      'operator': operator,
      'imageUrl': imageUrl,
    };
  }

  Vessel copyWith({
    int? id,
    String? vesselName,
    String? place,
    String? portRegistry,
    String? owner,
    String? flag,
    String? IMO,
    String? operator,
    String? imageUrl,
  }) {
    return Vessel(
      id: id ?? this.id,
      vesselName: vesselName ?? this.vesselName,
      place: place ?? this.place,
      portRegistry: portRegistry ?? this.portRegistry,
      owner: owner ?? this.owner,
      flag: flag ?? this.flag,
      IMO: IMO ?? this.IMO,
      operator: operator ?? this.operator,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
