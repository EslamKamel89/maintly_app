import 'uploader.dart';

class Attachment {
	int? id;
	int? organizationId;
	int? workOrderId;
	int? uploadedBy;
	String? type;
	String? notes;
	String? path;
	String? fileName;
	String? mimeType;
	int? fileSize;
	DateTime? createdAt;
	DateTime? updatedAt;
	Uploader? uploader;

	Attachment({
		this.id, 
		this.organizationId, 
		this.workOrderId, 
		this.uploadedBy, 
		this.type, 
		this.notes, 
		this.path, 
		this.fileName, 
		this.mimeType, 
		this.fileSize, 
		this.createdAt, 
		this.updatedAt, 
		this.uploader, 
	});

	@override
	String toString() {
		return 'Attachment(id: $id, organizationId: $organizationId, workOrderId: $workOrderId, uploadedBy: $uploadedBy, type: $type, notes: $notes, path: $path, fileName: $fileName, mimeType: $mimeType, fileSize: $fileSize, createdAt: $createdAt, updatedAt: $updatedAt, uploader: $uploader)';
	}

	factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
				id: json['id'] as int?,
				organizationId: json['organization_id'] as int?,
				workOrderId: json['work_order_id'] as int?,
				uploadedBy: json['uploaded_by'] as int?,
				type: json['type'] as String?,
				notes: json['notes'] as String?,
				path: json['path'] as String?,
				fileName: json['file_name'] as String?,
				mimeType: json['mime_type'] as String?,
				fileSize: json['file_size'] as int?,
				createdAt: json['created_at'] == null
						? null
						: DateTime.parse(json['created_at'] as String),
				updatedAt: json['updated_at'] == null
						? null
						: DateTime.parse(json['updated_at'] as String),
				uploader: json['uploader'] == null
						? null
						: Uploader.fromJson(json['uploader'] as Map<String, dynamic>),
			);

	Map<String, dynamic> toJson() => {
				'id': id,
				'organization_id': organizationId,
				'work_order_id': workOrderId,
				'uploaded_by': uploadedBy,
				'type': type,
				'notes': notes,
				'path': path,
				'file_name': fileName,
				'mime_type': mimeType,
				'file_size': fileSize,
				'created_at': createdAt?.toIso8601String(),
				'updated_at': updatedAt?.toIso8601String(),
				'uploader': uploader?.toJson(),
			};

	Attachment copyWith({
		int? id,
		int? organizationId,
		int? workOrderId,
		int? uploadedBy,
		String? type,
		String? notes,
		String? path,
		String? fileName,
		String? mimeType,
		int? fileSize,
		DateTime? createdAt,
		DateTime? updatedAt,
		Uploader? uploader,
	}) {
		return Attachment(
			id: id ?? this.id,
			organizationId: organizationId ?? this.organizationId,
			workOrderId: workOrderId ?? this.workOrderId,
			uploadedBy: uploadedBy ?? this.uploadedBy,
			type: type ?? this.type,
			notes: notes ?? this.notes,
			path: path ?? this.path,
			fileName: fileName ?? this.fileName,
			mimeType: mimeType ?? this.mimeType,
			fileSize: fileSize ?? this.fileSize,
			createdAt: createdAt ?? this.createdAt,
			updatedAt: updatedAt ?? this.updatedAt,
			uploader: uploader ?? this.uploader,
		);
	}
}
