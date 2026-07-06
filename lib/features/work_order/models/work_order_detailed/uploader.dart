class Uploader {
	int? id;
	int? organizationId;
	String? role;
	String? name;
	String? email;
	DateTime? emailVerifiedAt;
	DateTime? twoFactorConfirmedAt;
	DateTime? createdAt;
	DateTime? updatedAt;

	Uploader({
		this.id, 
		this.organizationId, 
		this.role, 
		this.name, 
		this.email, 
		this.emailVerifiedAt, 
		this.twoFactorConfirmedAt, 
		this.createdAt, 
		this.updatedAt, 
	});

	@override
	String toString() {
		return 'Uploader(id: $id, organizationId: $organizationId, role: $role, name: $name, email: $email, emailVerifiedAt: $emailVerifiedAt, twoFactorConfirmedAt: $twoFactorConfirmedAt, createdAt: $createdAt, updatedAt: $updatedAt)';
	}

	factory Uploader.fromJson(Map<String, dynamic> json) => Uploader(
				id: json['id'] as int?,
				organizationId: json['organization_id'] as int?,
				role: json['role'] as String?,
				name: json['name'] as String?,
				email: json['email'] as String?,
				emailVerifiedAt: json['email_verified_at'] == null
						? null
						: DateTime.parse(json['email_verified_at'] as String),
				twoFactorConfirmedAt: json['two_factor_confirmed_at'] == null
						? null
						: DateTime.parse(json['two_factor_confirmed_at'] as String),
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
				'role': role,
				'name': name,
				'email': email,
				'email_verified_at': emailVerifiedAt?.toIso8601String(),
				'two_factor_confirmed_at': twoFactorConfirmedAt?.toIso8601String(),
				'created_at': createdAt?.toIso8601String(),
				'updated_at': updatedAt?.toIso8601String(),
			};

	Uploader copyWith({
		int? id,
		int? organizationId,
		String? role,
		String? name,
		String? email,
		DateTime? emailVerifiedAt,
		DateTime? twoFactorConfirmedAt,
		DateTime? createdAt,
		DateTime? updatedAt,
	}) {
		return Uploader(
			id: id ?? this.id,
			organizationId: organizationId ?? this.organizationId,
			role: role ?? this.role,
			name: name ?? this.name,
			email: email ?? this.email,
			emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
			twoFactorConfirmedAt: twoFactorConfirmedAt ?? this.twoFactorConfirmedAt,
			createdAt: createdAt ?? this.createdAt,
			updatedAt: updatedAt ?? this.updatedAt,
		);
	}
}
