class LocationModel {
  int? id;
  String? name;

  LocationModel({this.id, this.name});

  @override
  String toString() => 'Location(id: $id, name: $name)';

  factory LocationModel.fromJson(Map<String, dynamic> json) =>
      LocationModel(id: json['id'] as int?, name: json['name'] as String?);

  Map<String, dynamic> toJson() => {'id': id, 'name': name};

  LocationModel copyWith({int? id, String? name}) {
    return LocationModel(id: id ?? this.id, name: name ?? this.name);
  }
}
