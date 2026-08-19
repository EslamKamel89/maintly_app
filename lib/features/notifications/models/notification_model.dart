class NotificationModel {
  final int? id;
  final String? routeName;
  final String? title;
  final String? content;
  final Map<String, dynamic>? payload;

  const NotificationModel({this.id, this.routeName, this.title, this.content, this.payload});

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] as int?,
      routeName: json['route_name'] as String?,
      title: json['title'] as String?,
      content: json['content'] as String?,
      payload: json['payload'] == null ? null : Map<String, dynamic>.from(json['payload'] as Map),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'route_name': routeName,
      'title': title,
      'content': content,
      'payload': payload,
    };
  }

  NotificationModel copyWith({
    int? id,
    String? routeName,
    String? title,
    String? content,
    Map<String, dynamic>? payload,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      routeName: routeName ?? this.routeName,
      title: title ?? this.title,
      content: content ?? this.content,
      payload: payload ?? this.payload,
    );
  }

  @override
  String toString() {
    return 'NotificationModel('
        'id: $id, '
        'routeName: $routeName, '
        'title: $title, '
        'content: $content, '
        'payload: $payload'
        ')';
  }
}
