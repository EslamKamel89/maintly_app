import 'asset.dart';
import 'attachment.dart';
import 'comment.dart';
import 'creator.dart';
import 'customer.dart';
import 'location.dart';
import 'technician.dart';

class WorkOrderDetailed {
	int? id;
	int? organizationId;
	int? customerId;
	int? locationId;
	int? createdBy;
	String? title;
	String? description;
	String? status;
	String? priority;
	DateTime? scheduledAt;
	DateTime? dueAt;
	DateTime? startedAt;
	DateTime? completedAt;
	DateTime? createdAt;
	DateTime? updatedAt;
	Customer? customer;
	Location? location;
	Creator? creator;
	List<Asset>? assets;
	List<Technician>? technicians;
	List<Comment>? comments;
	List<Attachment>? attachments;

	WorkOrderDetailed({
		this.id, 
		this.organizationId, 
		this.customerId, 
		this.locationId, 
		this.createdBy, 
		this.title, 
		this.description, 
		this.status, 
		this.priority, 
		this.scheduledAt, 
		this.dueAt, 
		this.startedAt, 
		this.completedAt, 
		this.createdAt, 
		this.updatedAt, 
		this.customer, 
		this.location, 
		this.creator, 
		this.assets, 
		this.technicians, 
		this.comments, 
		this.attachments, 
	});

	@override
	String toString() {
		return 'WorkOrderDetailed(id: $id, organizationId: $organizationId, customerId: $customerId, locationId: $locationId, createdBy: $createdBy, title: $title, description: $description, status: $status, priority: $priority, scheduledAt: $scheduledAt, dueAt: $dueAt, startedAt: $startedAt, completedAt: $completedAt, createdAt: $createdAt, updatedAt: $updatedAt, customer: $customer, location: $location, creator: $creator, assets: $assets, technicians: $technicians, comments: $comments, attachments: $attachments)';
	}

	factory WorkOrderDetailed.fromJson(Map<String, dynamic> json) {
		return WorkOrderDetailed(
			id: json['id'] as int?,
			organizationId: json['organization_id'] as int?,
			customerId: json['customer_id'] as int?,
			locationId: json['location_id'] as int?,
			createdBy: json['created_by'] as int?,
			title: json['title'] as String?,
			description: json['description'] as String?,
			status: json['status'] as String?,
			priority: json['priority'] as String?,
			scheduledAt: json['scheduled_at'] == null
						? null
						: DateTime.parse(json['scheduled_at'] as String),
			dueAt: json['due_at'] == null
						? null
						: DateTime.parse(json['due_at'] as String),
			startedAt: json['started_at'] == null
						? null
						: DateTime.parse(json['started_at'] as String),
			completedAt: json['completed_at'] == null
						? null
						: DateTime.parse(json['completed_at'] as String),
			createdAt: json['created_at'] == null
						? null
						: DateTime.parse(json['created_at'] as String),
			updatedAt: json['updated_at'] == null
						? null
						: DateTime.parse(json['updated_at'] as String),
			customer: json['customer'] == null
						? null
						: Customer.fromJson(json['customer'] as Map<String, dynamic>),
			location: json['location'] == null
						? null
						: Location.fromJson(json['location'] as Map<String, dynamic>),
			creator: json['creator'] == null
						? null
						: Creator.fromJson(json['creator'] as Map<String, dynamic>),
			assets: (json['assets'] as List<dynamic>?)
						?.map((e) => Asset.fromJson(e as Map<String, dynamic>))
						.toList(),
			technicians: (json['technicians'] as List<dynamic>?)
						?.map((e) => Technician.fromJson(e as Map<String, dynamic>))
						.toList(),
			comments: (json['comments'] as List<dynamic>?)
						?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
						.toList(),
			attachments: (json['attachments'] as List<dynamic>?)
						?.map((e) => Attachment.fromJson(e as Map<String, dynamic>))
						.toList(),
		);
	}



	Map<String, dynamic> toJson() => {
				'id': id,
				'organization_id': organizationId,
				'customer_id': customerId,
				'location_id': locationId,
				'created_by': createdBy,
				'title': title,
				'description': description,
				'status': status,
				'priority': priority,
				'scheduled_at': scheduledAt?.toIso8601String(),
				'due_at': dueAt?.toIso8601String(),
				'started_at': startedAt?.toIso8601String(),
				'completed_at': completedAt?.toIso8601String(),
				'created_at': createdAt?.toIso8601String(),
				'updated_at': updatedAt?.toIso8601String(),
				'customer': customer?.toJson(),
				'location': location?.toJson(),
				'creator': creator?.toJson(),
				'assets': assets?.map((e) => e.toJson()).toList(),
				'technicians': technicians?.map((e) => e.toJson()).toList(),
				'comments': comments?.map((e) => e.toJson()).toList(),
				'attachments': attachments?.map((e) => e.toJson()).toList(),
			};

	WorkOrderDetailed copyWith({
		int? id,
		int? organizationId,
		int? customerId,
		int? locationId,
		int? createdBy,
		String? title,
		String? description,
		String? status,
		String? priority,
		DateTime? scheduledAt,
		DateTime? dueAt,
		DateTime? startedAt,
		DateTime? completedAt,
		DateTime? createdAt,
		DateTime? updatedAt,
		Customer? customer,
		Location? location,
		Creator? creator,
		List<Asset>? assets,
		List<Technician>? technicians,
		List<Comment>? comments,
		List<Attachment>? attachments,
	}) {
		return WorkOrderDetailed(
			id: id ?? this.id,
			organizationId: organizationId ?? this.organizationId,
			customerId: customerId ?? this.customerId,
			locationId: locationId ?? this.locationId,
			createdBy: createdBy ?? this.createdBy,
			title: title ?? this.title,
			description: description ?? this.description,
			status: status ?? this.status,
			priority: priority ?? this.priority,
			scheduledAt: scheduledAt ?? this.scheduledAt,
			dueAt: dueAt ?? this.dueAt,
			startedAt: startedAt ?? this.startedAt,
			completedAt: completedAt ?? this.completedAt,
			createdAt: createdAt ?? this.createdAt,
			updatedAt: updatedAt ?? this.updatedAt,
			customer: customer ?? this.customer,
			location: location ?? this.location,
			creator: creator ?? this.creator,
			assets: assets ?? this.assets,
			technicians: technicians ?? this.technicians,
			comments: comments ?? this.comments,
			attachments: attachments ?? this.attachments,
		);
	}
}
