import '../../../../core/api/api_constants.dart';
import '../../../../core/api/api_consumer.dart';
import '../models/client_models.dart';

abstract class ClientRemoteDataSource {
  Future<ClientStatsModel> getClientStats();
  Future<List<ClientListItemModel>> getClientsList({String? search, String? ordersLevel});
  Future<ClientDetailModel> getClientDetails(String id);
}

class ClientRemoteDataSourceImpl implements ClientRemoteDataSource {
  final ApiConsumer apiConsumer;

  ClientRemoteDataSourceImpl(this.apiConsumer);

  @override
  Future<ClientStatsModel> getClientStats() async {
    final response = await apiConsumer.get(ApiConstants.customerStats);
    // 🟢 السيرفر بيرجع البيانات جوه مفتاح "data"
    final Map<String, dynamic> statsData = response['data'] ?? response;
    return ClientStatsModel.fromJson(statsData);
  }

  @override
  Future<List<ClientListItemModel>> getClientsList({String? search, String? ordersLevel}) async {
    final response = await apiConsumer.get(
      ApiConstants.customersList,
      queryParameters: {
        if (search != null && search.isNotEmpty) 'search': search,
        if (ordersLevel != null && ordersLevel.isNotEmpty) 'ordersLevel': ordersLevel,
        'page': 1,
        'limit': 20,
      },
    );

    // 🟢 حل مشكلة الـ Type: استخراج الـ List من response['data']['items'] بأمان
    List<dynamic> itemsList = [];
    if (response is Map<String, dynamic>) {
      final data = response['data'];
      if (data is Map<String, dynamic>) {
        itemsList = data['items'] as List? ?? [];
      } else if (data is List) {
        itemsList = data;
      }
    } else if (response is List) {
      itemsList = response;
    }

    return itemsList.map((json) => ClientListItemModel.fromJson(json)).toList();
  }

  @override
  Future<ClientDetailModel> getClientDetails(String id) async {
    final response = await apiConsumer.get(ApiConstants.customerDetails(id));
    // 🟢 تفاصيل العميل مغلفة جوه مفتاح "data"
    final Map<String, dynamic> detailsData = response['data'] ?? response;
    return ClientDetailModel.fromJson(detailsData);
  }
}