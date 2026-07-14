import 'package:dio/dio.dart' show MultipartFile;
import 'package:image_picker/image_picker.dart' show XFile;
import 'package:maintly_app/core/api_service/api_consumer.dart';
import 'package:maintly_app/core/api_service/end_points.dart';
import 'package:maintly_app/core/enums/response_type.dart';
import 'package:maintly_app/core/heleprs/print_helper.dart';
import 'package:maintly_app/core/models/api_response_model.dart';
import 'package:maintly_app/core/service_locator/service_locator.dart';
import 'package:maintly_app/core/services/base_service.dart';
import 'package:maintly_app/features/work_order/models/work_order_detailed/work_order_detailed.dart';
import 'package:maintly_app/features/work_order/models/work_order_model/work_order_model.dart';

class WorkOrdersService extends BaseService {
  WorkOrdersService();

  final ApiConsumer api = serviceLocator<ApiConsumer>();

  Future<ApiResponseModel<List<WorkOrderModel>>> getWorkOrders() async {
    const t = 'getWorkOrders - WorkOrdersService';

    try {
      final raw = await api.get(EndPoint.workOrdersEndpoint);

      pr(raw, '$t - raw response');

      final List<WorkOrderModel> workOrders = (raw as List)
          .map((e) => WorkOrderModel.fromJson(e as Map<String, dynamic>))
          .toList();

      return ApiResponseModel(response: ResponseEnum.success, data: workOrders);
    } catch (e) {
      return apiExceptionHandler<List<WorkOrderModel>>(e);
    }
  }

  Future<ApiResponseModel<WorkOrderDetailed>> getWorkOrder(int workOrderId) async {
    const t = 'getWorkOrder - WorkOrdersService';

    try {
      final raw = await api.get("${EndPoint.workOrdersEndpoint}/$workOrderId");

      pr(raw, '$t - raw response');

      final WorkOrderDetailed workOrder = WorkOrderDetailed.fromJson(raw);

      return ApiResponseModel(response: ResponseEnum.success, data: workOrder);
    } catch (e) {
      return apiExceptionHandler<WorkOrderDetailed>(e);
    }
  }

  Future<ApiResponseModel<void>> uploadAttachment({
    required int workOrderId,
    required String type,
    required XFile image,
    String? notes,
  }) async {
    const t = 'uploadAttachment - WorkOrdersService';

    try {
      final file = await MultipartFile.fromFile(
        image.path,
        filename: image.name,
      );
      await api.post(
        EndPoint.attachmentsEndpoint,
        data: {
          'work_order_id': workOrderId,
          'type': type,
          'attachment': file,
          if (notes != null && notes.isNotEmpty) 'notes': notes,
        },
        isFormData: true,
      );

      pr(null, '$t - success');

      return ApiResponseModel<void>(response: ResponseEnum.success);
    } catch (e) {
      return apiExceptionHandler<void>(e);
    }
  }

  Future<ApiResponseModel<void>> createComment({
    required int workOrderId,
    required String comment,
  }) async {
    const t = 'createComment - WorkOrdersService';

    try {
      await api.post(
        EndPoint.commentsEndpoint,
        data: {'work_order_id': workOrderId, 'comment': comment},
      );

      pr(null, '$t - success');

      return ApiResponseModel<void>(response: ResponseEnum.success);
    } catch (e) {
      return apiExceptionHandler<void>(e);
    }
  }
}
