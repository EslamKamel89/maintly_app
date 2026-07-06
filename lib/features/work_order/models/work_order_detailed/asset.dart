class Asset {
	int? id;
	int? organizationId;
	int? locationId;
	String? name;
	String? assetCode;
	String? manufacturer;
	String? model;
	String? serialNumber;
	String? notes;
	DateTime? createdAt;
	DateTime? updatedAt;

	Asset({
		this.id, 
		this.organizationId, 
		this.locationId, 
		this.name, 
		this.assetCode, 
		this.manufacturer, 
		this.model, 
		this.serialNumber, 
		this.notes, 
		this.createdAt, 
		this.updatedAt, 
	});

	@override
	String toString() {
		return 'Asset(id: $id, organizationId: $organizationId, locationId: $locationId, name: $name, assetCode: $assetCode, manufacturer: $manufacturer, model: $model, serialNumber: $serialNumber, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt)';
	}

	factory Asset.fromJson(Map<String, dynamic> json) => Asset(
				id: json['id'] as int?,
				organizationId: json['organization_id'] as int?,
				locationId: json['location_id'] as int?,
				name: json['name'] as String?,
				assetCode: json['asset_code'] as String?,
				manufacturer: json['manufacturer'] as String?,
				model: json['model'] as String?,
				serialNumber: json['serial_number'] as String?,
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
				'location_id': locationId,
				'name': name,
				'asset_code': assetCode,
				'manufacturer': manufacturer,
				'model': model,
				'serial_number': serialNumber,
				'notes': notes,
				'created_at': createdAt?.toIso8601String(),
				'updated_at': updatedAt?.toIso8601String(),
			};

	Asset copyWith({
		int? id,
		int? organizationId,
		int? locationId,
		String? name,
		String? assetCode,
		String? manufacturer,
		String? model,
		String? serialNumber,
		String? notes,
		DateTime? createdAt,
		DateTime? updatedAt,
	}) {
		return Asset(
			id: id ?? this.id,
			organizationId: organizationId ?? this.organizationId,
			locationId: locationId ?? this.locationId,
			name: name ?? this.name,
			assetCode: assetCode ?? this.assetCode,
			manufacturer: manufacturer ?? this.manufacturer,
			model: model ?? this.model,
			serialNumber: serialNumber ?? this.serialNumber,
			notes: notes ?? this.notes,
			createdAt: createdAt ?? this.createdAt,
			updatedAt: updatedAt ?? this.updatedAt,
		);
	}
}
