class Location {
	int? id;
	int? organizationId;
	int? customerId;
	String? name;
	String? address;
	String? city;
	String? state;
	double? latitude;
	double? longitude;
	String? notes;
	DateTime? createdAt;
	DateTime? updatedAt;

	Location({
		this.id, 
		this.organizationId, 
		this.customerId, 
		this.name, 
		this.address, 
		this.city, 
		this.state, 
		this.latitude, 
		this.longitude, 
		this.notes, 
		this.createdAt, 
		this.updatedAt, 
	});

	@override
	String toString() {
		return 'Location(id: $id, organizationId: $organizationId, customerId: $customerId, name: $name, address: $address, city: $city, state: $state, latitude: $latitude, longitude: $longitude, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt)';
	}

	factory Location.fromJson(Map<String, dynamic> json) => Location(
				id: json['id'] as int?,
				organizationId: json['organization_id'] as int?,
				customerId: json['customer_id'] as int?,
				name: json['name'] as String?,
				address: json['address'] as String?,
				city: json['city'] as String?,
				state: json['state'] as String?,
				latitude: (json['latitude'] as num?)?.toDouble(),
				longitude: (json['longitude'] as num?)?.toDouble(),
				notes: json['notes'] as String?,
				createdAt: json['created_at'] == null
						? null
						: DateTime.parse(json['created_at'] as String),
				updatedAt: json['updated_at'] == null
						? null
						: DateTime.parse(json['updated_at'] as String),
			);

	Map<String, dynamic> toJson() => {
				'id': id,
				'organization_id': organizationId,
				'customer_id': customerId,
				'name': name,
				'address': address,
				'city': city,
				'state': state,
				'latitude': latitude,
				'longitude': longitude,
				'notes': notes,
				'created_at': createdAt?.toIso8601String(),
				'updated_at': updatedAt?.toIso8601String(),
			};

	Location copyWith({
		int? id,
		int? organizationId,
		int? customerId,
		String? name,
		String? address,
		String? city,
		String? state,
		double? latitude,
		double? longitude,
		String? notes,
		DateTime? createdAt,
		DateTime? updatedAt,
	}) {
		return Location(
			id: id ?? this.id,
			organizationId: organizationId ?? this.organizationId,
			customerId: customerId ?? this.customerId,
			name: name ?? this.name,
			address: address ?? this.address,
			city: city ?? this.city,
			state: state ?? this.state,
			latitude: latitude ?? this.latitude,
			longitude: longitude ?? this.longitude,
			notes: notes ?? this.notes,
			createdAt: createdAt ?? this.createdAt,
			updatedAt: updatedAt ?? this.updatedAt,
		);
	}
}
