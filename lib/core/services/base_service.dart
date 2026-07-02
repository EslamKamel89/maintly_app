import 'package:maintly_app/core/Errors/failure.dart';
import 'package:maintly_app/core/enums/response_type.dart';
import 'package:maintly_app/core/heleprs/snackbar.dart';
import 'package:maintly_app/core/models/api_response_model.dart';

abstract class BaseService {
  ApiResponseModel<T> apiExceptionHandler<T>(Object error) {
    if (error is ValidationFailure) {
      return _failureResponse<T>(title: 'Validation Error', message: error.message);
    }

    if (error is OfflineFailure) {
      return _failureResponse<T>(title: 'Offline', message: error.message);
    }

    if (error is UnauthorizedFailure) {
      // TODO:
      // - Clear stored token.
      // - Logout current user.
      // - Navigate to Sign In.

      return _failureResponse<T>(title: 'Unauthorized', message: error.message);
    }

    if (error is ForbiddenFailure) {
      return _failureResponse<T>(title: 'Access Denied', message: error.message);
    }

    if (error is NotFoundFailure) {
      return _failureResponse<T>(title: 'Not Found', message: error.message);
    }

    if (error is ServerFailure) {
      return _failureResponse<T>(title: 'Server Error', message: error.message);
    }

    if (error is Failure) {
      return _failureResponse<T>(title: 'Error', message: error.message);
    }

    return _failureResponse<T>(title: 'Unexpected Error', message: error.toString());
  }

  ApiResponseModel<T> _failureResponse<T>({required String title, required String message}) {
    showSnackbar(title, message, true);

    return ApiResponseModel<T>(response: ResponseEnum.failed, errorMessage: message);
  }
}
