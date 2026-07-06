class Customer {
	int? id;
	int? organizationId;
	String? companyName;
	String? contactPerson;
	String? phone;
	String? email;
	String? notes;
	DateTime? createdAt;
	DateTime? updatedAt;

	Customer({
		this.id, 
		this.organizationId, 
		this.companyName, 
		this.contactPerson, 
		this.phone, 
		this.email, 
		this.notes, 
		this.createdAt, 
		this.updatedAt, 
	});

	@override
	String toString() {
		return 'Customer(id: $id, organizationId: $organizationId, companyName: $companyName, contactPerson: $contactPerson, phone: $phone, email: $email, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt)';
	}

	factory Customer.fromJson(Map<String, dynamic> json) => Customer(
				id: json['id'] as int?,
				organizationId: json['organization_id'] as int?,
				companyName: json['company_name'] as String?,
				contactPerson: json['contact_person'] as String?,
				phone: json['phone'] as String?,
				email: json['email'] as String?,
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
				'company_name': companyName,
				'contact_person': contactPerson,
				'phone': phone,
				'email': email,
				'notes': notes,
				'created_at': createdAt?.toIso8601String(),
				'updated_at': updatedAt?.toIso8601String(),
			};

	Customer copyWith({
		int? id,
		int? organizationId,
		String? companyName,
		String? contactPerson,
		String? phone,
		String? email,
		String? notes,
		DateTime? createdAt,
		DateTime? updatedAt,
	}) {
		return Customer(
			id: id ?? this.id,
			organizationId: organizationId ?? this.organizationId,
			companyName: companyName ?? this.companyName,
			contactPerson: contactPerson ?? this.contactPerson,
			phone: phone ?? this.phone,
			email: email ?? this.email,
			notes: notes ?? this.notes,
			createdAt: createdAt ?? this.createdAt,
			updatedAt: updatedAt ?? this.updatedAt,
		);
	}
}
