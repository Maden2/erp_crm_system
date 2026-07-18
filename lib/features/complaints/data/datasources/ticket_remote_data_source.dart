import '../../../../core/api/api_constants.dart';
import '../../../../core/api/api_consumer.dart';
import '../models/ticket_models.dart';

abstract class TicketRemoteDataSource {
  Future<Map<String, dynamic>> getComplaintsList({
    String? status,
    String? dateFilter,
    String? search,
  });
  Future<TicketDetailModel> getComplaintDetails(String id);
  Future<void> updateComplaintStatus(String id, String status);
  Future<void> createTestimonial(String customerName, int rating, String comment);
}

class TicketRemoteDataSourceImpl implements TicketRemoteDataSource {
  final ApiConsumer apiConsumer;

  TicketRemoteDataSourceImpl(this.apiConsumer);

  @override
  Future<Map<String, dynamic>> getComplaintsList({
    String? status,
    String? dateFilter,
    String? search,
  }) async {
    final response = await apiConsumer.get(
      ApiConstants.complaintsListAndStats,
      queryParameters: {
        if (status != null && status != 'all') 'status': status,
        if (dateFilter != null) 'dateFilter': dateFilter,
        if (search != null && search.isNotEmpty) 'search': search,
        'page': 1,
        'limit': 20,
      },
    );

    final dataMap = response['data'] as Map<String, dynamic>? ?? {};
    final stats = TicketStatsModel.fromJson(dataMap['stats'] ?? {});

    final List<dynamic> itemsJson = dataMap['items'] as List? ?? [];
    final items = itemsJson.map((json) => TicketItemModel.fromJson(json)).toList();

    return {
      'stats': stats,
      'items': items,
    };
  }

  @override
  Future<TicketDetailModel> getComplaintDetails(String id) async {
    final response = await apiConsumer.get(ApiConstants.complaintDetails(id));
    final detailData = response['data'] ?? response;
    return TicketDetailModel.fromJson(detailData);
  }

  @override
  Future<void> updateComplaintStatus(String id, String status) async {
    await apiConsumer.patch(
      ApiConstants.updateComplaintStatus(id),
      data: {'status': status},
    );
  }

  @override
  Future<void> createTestimonial(String customerName, int rating, String comment) async {
    await apiConsumer.post(
      ApiConstants.createTestimonial,
      data: {
        'customerName': customerName,
        'rating': rating,
        'comment': comment,
      },
    );
  }
}