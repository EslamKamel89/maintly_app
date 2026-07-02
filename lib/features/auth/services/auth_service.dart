import 'package:maintly_app/core/api_service/api_consumer.dart';
import 'package:maintly_app/core/api_service/end_points.dart';
import 'package:maintly_app/core/enums/response_type.dart';
import 'package:maintly_app/core/heleprs/print_helper.dart';
import 'package:maintly_app/core/models/api_response_model.dart';
import 'package:maintly_app/core/service_locator/service_locator.dart';
import 'package:maintly_app/core/services/base_service.dart';
import 'package:maintly_app/features/auth/models/response/auth_response.dart';

class AuthService extends BaseService {
  AuthService();

  final ApiConsumer api = serviceLocator<ApiConsumer>();

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
      final AuthResponse model = AuthResponse.fromJson(raw);
      return ApiResponseModel(data: model, response: ResponseEnum.success);
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

      return ApiResponseModel(response: ResponseEnum.success, data: model);
    } catch (e) {
      return apiExceptionHandler<AuthResponse>(e);
    }
  }
}
