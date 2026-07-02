class Organization {
  int? id;
  String? name;
  String? address;
  String? phoneNumber;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;

  Organization({
    this.id,
    this.name,
    this.address,
    this.phoneNumber,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  @override
  String toString() {
    return 'Organization(id: $id, name: $name, address: $address, phoneNumber: $phoneNumber, description: $description, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  factory Organization.fromJson(Map<String, dynamic> data) => Organization(
    id: data['id'] as int?,
    name: data['name'] as String?,
    address: data['address'] as String?,
    phoneNumber: data['phone_number'] as String?,
    description: data['description'] as String?,
    createdAt: data['created_at'] == null ? null : DateTime.parse(data['created_at'] as String),
    updatedAt: data['updated_at'] == null ? null : DateTime.parse(data['updated_at'] as String),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'address': address,
    'phone_number': phoneNumber,
    'description': description,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
  };

  Organization copyWith({
    int? id,
    String? name,
    String? address,
    String? phoneNumber,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Organization(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
