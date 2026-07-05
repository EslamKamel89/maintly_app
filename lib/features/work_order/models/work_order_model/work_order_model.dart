import 'customer_model.dart';
import 'location_model.dart';

class WorkOrderModel {
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
  CustomerModel? customer;
  LocationModel? location;

  WorkOrderModel({
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
  });

  @override
  String toString() {
    return 'WorkOrderModel(id: $id, organizationId: $organizationId, customerId: $customerId, locationId: $locationId, createdBy: $createdBy, title: $title, description: $description, status: $status, priority: $priority, scheduledAt: $scheduledAt, dueAt: $dueAt, startedAt: $startedAt, completedAt: $completedAt, createdAt: $createdAt, updatedAt: $updatedAt, customer: $customer, location: $location)';
  }

  factory WorkOrderModel.fromJson(Map<String, dynamic> json) {
    return WorkOrderModel(
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
      dueAt: json['due_at'] == null ? null : DateTime.parse(json['due_at'] as String),
      startedAt: json['started_at'] == null ? null : DateTime.parse(json['started_at'] as String),
      completedAt: json['completed_at'] == null
          ? null
          : DateTime.parse(json['completed_at'] as String),
      createdAt: json['created_at'] == null ? null : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null ? null : DateTime.parse(json['updated_at'] as String),
      customer: json['customer'] == null
          ? null
          : CustomerModel.fromJson(json['customer'] as Map<String, dynamic>),
      location: json['location'] == null
          ? null
          : LocationModel.fromJson(json['location'] as Map<String, dynamic>),
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
  };

  WorkOrderModel copyWith({
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
    CustomerModel? customer,
    LocationModel? location,
  }) {
    return WorkOrderModel(
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
    );
  }
}
