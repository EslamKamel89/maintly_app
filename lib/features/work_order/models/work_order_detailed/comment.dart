import 'user.dart';

class Comment {
	int? id;
	int? organizationId;
	int? workOrderId;
	int? userId;
	String? comment;
	DateTime? createdAt;
	DateTime? updatedAt;
	User? user;

	Comment({
		this.id, 
		this.organizationId, 
		this.workOrderId, 
		this.userId, 
		this.comment, 
		this.createdAt, 
		this.updatedAt, 
		this.user, 
	});

	@override
	String toString() {
		return 'Comment(id: $id, organizationId: $organizationId, workOrderId: $workOrderId, userId: $userId, comment: $comment, createdAt: $createdAt, updatedAt: $updatedAt, user: $user)';
	}

	factory Comment.fromJson(Map<String, dynamic> json) => Comment(
				id: json['id'] as int?,
				organizationId: json['organization_id'] as int?,
				workOrderId: json['work_order_id'] as int?,
				userId: json['user_id'] as int?,
				comment: json['comment'] as String?,
				createdAt: json['created_at'] == null
						? null
						: DateTime.parse(json['created_at'] as String),
				updatedAt: json['updated_at'] == null
						? null
						: DateTime.parse(json['updated_at'] as String),
				user: json['user'] == null
						? null
						: User.fromJson(json['user'] as Map<String, dynamic>),
			);

	Map<String, dynamic> toJson() => {
				'id': id,
				'organization_id': organizationId,
				'work_order_id': workOrderId,
				'user_id': userId,
				'comment': comment,
				'created_at': createdAt?.toIso8601String(),
				'updated_at': updatedAt?.toIso8601String(),
				'user': user?.toJson(),
			};

	Comment copyWith({
		int? id,
		int? organizationId,
		int? workOrderId,
		int? userId,
		String? comment,
		DateTime? createdAt,
		DateTime? updatedAt,
		User? user,
	}) {
		return Comment(
			id: id ?? this.id,
			organizationId: organizationId ?? this.organizationId,
			workOrderId: workOrderId ?? this.workOrderId,
			userId: userId ?? this.userId,
			comment: comment ?? this.comment,
			createdAt: createdAt ?? this.createdAt,
			updatedAt: updatedAt ?? this.updatedAt,
			user: user ?? this.user,
		);
	}
}
