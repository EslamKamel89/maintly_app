import 'dart:convert';

class NotificationModel {
  final String? routeName;
  final String? title;
  final String? content;
  final Map<String, dynamic>? payload;

  const NotificationModel({this.routeName, this.title, this.content, this.payload});

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic>? parsePayload(dynamic value) {
      if (value == null) {
        return null;
      }

      if (value is Map<String, dynamic>) {
        return value;
      }

      if (value is String && value.trim().isNotEmpty) {
        final decoded = jsonDecode(value);

        if (decoded is Map) {
          return Map<String, dynamic>.from(decoded);
        }
      }

      return null;
    }

    return NotificationModel(
      routeName: json['route_name'] as String?,
      title: json['title'] as String?,
      content: json['content'] as String?,
      payload: parsePayload(json['payload']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'route_name': routeName, 'title': title, 'content': content, 'payload': payload};
  }

  NotificationModel copyWith({
    String? routeName,
    String? title,
    String? content,
    Map<String, dynamic>? payload,
  }) {
    return NotificationModel(
      routeName: routeName ?? this.routeName,
      title: title ?? this.title,
      content: content ?? this.content,
      payload: payload ?? this.payload,
    );
  }

  @override
  String toString() {
    return 'NotificationModel('
        'routeName: $routeName, '
        'title: $title, '
        'content: $content, '
        'payload: $payload'
        ')';
  }
}
