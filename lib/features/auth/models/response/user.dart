import 'organization.dart';

class User {
  int? id;
  int? organizationId;
  String? role;
  String? name;
  String? email;
  dynamic emailVerifiedAt;
  dynamic twoFactorConfirmedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  Organization? organization;

  User({
    this.id,
    this.organizationId,
    this.role,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.twoFactorConfirmedAt,
    this.createdAt,
    this.updatedAt,
    this.organization,
  });

  @override
  String toString() {
    return 'User(id: $id, organizationId: $organizationId, role: $role, name: $name, email: $email, emailVerifiedAt: $emailVerifiedAt, twoFactorConfirmedAt: $twoFactorConfirmedAt, createdAt: $createdAt, updatedAt: $updatedAt, organization: $organization)';
  }

  factory User.fromJson(Map<String, dynamic> data) => User(
    id: data['id'] as int?,
    organizationId: data['organization_id'] as int?,
    role: data['role'] as String?,
    name: data['name'] as String?,
    email: data['email'] as String?,
    emailVerifiedAt: data['email_verified_at'] as dynamic,
    twoFactorConfirmedAt: data['two_factor_confirmed_at'] as dynamic,
    createdAt: data['created_at'] == null ? null : DateTime.parse(data['created_at'] as String),
    updatedAt: data['updated_at'] == null ? null : DateTime.parse(data['updated_at'] as String),
    organization: data['organization'] == null
        ? null
        : Organization.fromJson(data['organization'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'organization_id': organizationId,
    'role': role,
    'name': name,
    'email': email,
    'email_verified_at': emailVerifiedAt,
    'two_factor_confirmed_at': twoFactorConfirmedAt,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
    'organization': organization?.toJson(),
  };

  User copyWith({
    int? id,
    int? organizationId,
    String? role,
    String? name,
    String? email,
    dynamic emailVerifiedAt,
    dynamic twoFactorConfirmedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    Organization? organization,
  }) {
    return User(
      id: id ?? this.id,
      organizationId: organizationId ?? this.organizationId,
      role: role ?? this.role,
      name: name ?? this.name,
      email: email ?? this.email,
      emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
      twoFactorConfirmedAt: twoFactorConfirmedAt ?? this.twoFactorConfirmedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      organization: organization ?? this.organization,
    );
  }
}
