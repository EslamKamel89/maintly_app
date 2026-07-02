import 'user.dart';

class AuthResponse {
  String? message;
  String? token;
  User? user;

  AuthResponse({this.message, this.token, this.user});

  @override
  String toString() {
    return 'Response(message: $message, token: $token, user: $user)';
  }

  factory AuthResponse.fromJson(Map<String, dynamic> data) => AuthResponse(
    message: data['message'] as String?,
    token: data['token'] as String?,
    user: data['user'] == null ? null : User.fromJson(data['user'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {'message': message, 'token': token, 'user': user?.toJson()};
}
