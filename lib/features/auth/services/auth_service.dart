import 'dart:convert';

import 'package:maintly_app/core/api_service/api_consumer.dart';
import 'package:maintly_app/core/api_service/end_points.dart';
import 'package:maintly_app/core/enums/response_type.dart';
import 'package:maintly_app/core/heleprs/print_helper.dart';
import 'package:maintly_app/core/models/api_response_model.dart';
import 'package:maintly_app/core/service_locator/service_locator.dart';
import 'package:maintly_app/core/services/base_service.dart';
import 'package:maintly_app/core/static_data/shared_prefrences_key.dart';
import 'package:maintly_app/features/auth/models/response/auth_response.dart';
import 'package:maintly_app/features/auth/models/response/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends BaseService {
  AuthService();

  final ApiConsumer api = serviceLocator<ApiConsumer>();

  final SharedPreferences shPref = serviceLocator<SharedPreferences>();

  Future<ApiResponseModel<AuthResponse>> login({
    required String email,
    required String password,
  }) async {
    const t = 'login - AuthService';

    try {
      final raw = await api.post(
        EndPoint.loginEndpoint,
        data: {'email': email, 'password': password},
      );

      pr(raw, '$t - raw response');

      final model = AuthResponse.fromJson(raw);
      await cacheSession(model);

      return ApiResponseModel(response: ResponseEnum.success, data: model);
    } catch (e) {
      return apiExceptionHandler<AuthResponse>(e);
    }
  }

  Future<ApiResponseModel<AuthResponse>> register({
    required String name,
    required String email,
    required String password,
    required String organizationName,
  }) async {
    const t = 'register - AuthService';

    try {
      final raw = await api.post(
        EndPoint.registerEndpoint,
        data: {
          'name': name,
          'email': email,
          'password': password,
          'organization_name': organizationName,
        },
      );

      pr(raw, '$t - raw response');

      final model = AuthResponse.fromJson(raw);
      await cacheSession(model);
      return ApiResponseModel(response: ResponseEnum.success, data: model);
    } catch (e) {
      return apiExceptionHandler<AuthResponse>(e);
    }
  }

  Future<void> cacheSession(AuthResponse response) async {
    if (response.token != null) {
      await cacheToken(response.token!);
    }

    if (response.user != null) {
      await cacheUser(response.user!);
    }
  }

  Future<void> cacheToken(String token) async {
    await shPref.setString(ShPrefKey.token, token);
  }

  String? getToken() {
    return shPref.getString(ShPrefKey.token);
  }

  bool isSignedIn() {
    final token = getToken();

    return token != null && token.isNotEmpty;
  }

  Future<void> cacheUser(User user) async {
    await shPref.setString(ShPrefKey.user, jsonEncode(user.toJson()));
  }

  User? getCachedUser() {
    final raw = shPref.getString(ShPrefKey.user);

    if (raw == null || raw.isEmpty) {
      return null;
    }

    return User.fromJson(jsonDecode(raw));
  }

  Future<void> clearSession() async {
    await shPref.remove(ShPrefKey.token);
    await shPref.remove(ShPrefKey.user);
    await shPref.remove(ShPrefKey.onBoarding);
  }

  Future<void> logout() async {
    await clearSession();
  }

  Future<void> setOnBoardingSeen() async {
    await shPref.setBool(ShPrefKey.onBoarding, true);
  }

  bool isOnBoardingSeen() {
    return shPref.getBool(ShPrefKey.onBoarding) ?? false;
  }
}
