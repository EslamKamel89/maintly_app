import 'package:geolocator/geolocator.dart';
import 'package:maintly_app/core/api_service/api_consumer.dart';
import 'package:maintly_app/core/api_service/end_points.dart';
import 'package:maintly_app/core/enums/response_type.dart';
import 'package:maintly_app/core/heleprs/print_helper.dart';
import 'package:maintly_app/core/models/api_response_model.dart';
import 'package:maintly_app/core/service_locator/service_locator.dart';
import 'package:maintly_app/core/services/base_service.dart';
import 'package:maintly_app/features/auth/services/auth_service.dart';

class TechnicianLocationApiService extends BaseService {
  TechnicianLocationApiService();

  final ApiConsumer api = serviceLocator<ApiConsumer>();

  final AuthService authService = serviceLocator<AuthService>();

  Future<ApiResponseModel<void>> updateLocation(Position position) async {
    const t = 'updateLocation - TechnicianLocationApiService';

    if (!authService.isSignedIn()) {
      return ApiResponseModel<void>(response: ResponseEnum.success);
    }

    final user = authService.getCachedUser();
    if (user?.role != 'technician') {
      return ApiResponseModel<void>(response: ResponseEnum.success);
    }
    if (!position.latitude.isFinite || !position.longitude.isFinite) {
      return ApiResponseModel<void>(response: ResponseEnum.success);
    }

    try {
      await api.post(
        EndPoint.technicianLocationEndpoint,
        data: {'latitude': position.latitude, 'longitude': position.longitude},
      );

      pr(null, '$t - success');

      return ApiResponseModel<void>(response: ResponseEnum.success);
    } catch (e) {
      return apiExceptionHandler<void>(e);
    }
  }
}
