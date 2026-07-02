import '../../../../core/api/api_consumer.dart';
import '../models/live_order_model.dart';
import '../models/live_order_status_meta_model.dart';
import '../models/orders_pagination_meta_model.dart';

abstract class LiveOrdersRemoteDataSource {
  Future<List<LiveOrderModel>> getOrders({int? status, String? search, int? page, int? limit});
  Future<LiveOrderModel> getOrderDetails(String id);
  Future<List<LiveOrderStatusMetaModel>> getOrderStatuses();
  Future<List<Map<String, dynamic>>> getOrderSummary();
  Future<Map<String, dynamic>> updateOrderStatus(String id, int status);
}

class LiveOrdersRemoteDataSourceImpl implements LiveOrdersRemoteDataSource {
  final ApiConsumer apiConsumer;

  LiveOrdersRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<List<LiveOrderModel>> getOrders({int? status, String? search, int? page, int? limit}) async {
    final response = await apiConsumer.get(
      "/api/orders",
      queryParameters: {
        if (status != null) 'status': status,
        if (search != null && search.isNotEmpty) 'search': search,
        if (page != null) 'page': page,
        if (limit != null) 'limit': limit,
      },
    );

    final List<dynamic> data = response['data'] as List<dynamic>;
    return data.map((json) => LiveOrderModel.fromJson(json as Map<String, dynamic>)).toList();
  }

  @override
  Future<LiveOrderModel> getOrderDetails(String id) async {
    final response = await apiConsumer.get("/api/orders/$id");
    return LiveOrderModel.fromJson(response['data'] as Map<String, dynamic>);
  }

  @override
  Future<List<LiveOrderStatusMetaModel>> getOrderStatuses() async {
    final response = await apiConsumer.get("/api/orders/statuses");
    final List<dynamic> data = response['data'] as List<dynamic>;
    return data.map((json) => LiveOrderStatusMetaModel.fromJson(json as Map<String, dynamic>)).toList();
  }

  @override
  Future<List<Map<String, dynamic>>> getOrderSummary() async {
    final response = await apiConsumer.get("/api/orders/summary");
    return List<Map<String, dynamic>>.from(response['data'] as List);
  }

  @override
  Future<Map<String, dynamic>> updateOrderStatus(String id, int status) async {
    final response = await apiConsumer.patch(
      "/api/orders/$id/status",
      data: {'status': status},
    );
    return response['data'] as Map<String, dynamic>;
  }
}