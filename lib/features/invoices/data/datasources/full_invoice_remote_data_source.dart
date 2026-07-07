import '../../../../core/api/api_constants.dart';
import '../../../../core/api/api_consumer.dart';
import '../models/full_invoice_models.dart';

abstract class FullInvoiceRemoteDataSource {
  Future<List<FullInvoiceStatusDefinitionModel>> getInvoiceStatuses();
  Future<FullInvoiceStatsModel> getInvoiceStats();
  Future<FullInvoiceListModel> getInvoices({
    required int page,
    required int limit,
    String? search,
    String? status,
    String? timePeriod,
    String? paymentMethod,
    String? dateFrom,
    String? dateTo,
  });
  Future<FullInvoiceModel> getInvoiceDetails(String id);
}

class FullInvoiceRemoteDataSourceImpl implements FullInvoiceRemoteDataSource {
  final ApiConsumer apiConsumer;

  FullInvoiceRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<List<FullInvoiceStatusDefinitionModel>> getInvoiceStatuses() async {
    final response = await apiConsumer.get(ApiConstants.invoiceStatuses);
    return (response['data'] as List)
        .map((e) => FullInvoiceStatusDefinitionModel.fromJson(e))
        .toList();
  }

  @override
  Future<FullInvoiceStatsModel> getInvoiceStats() async {
    final response = await apiConsumer.get(ApiConstants.invoiceStats);
    return FullInvoiceStatsModel.fromJson(response['data']);
  }

  @override
  Future<FullInvoiceListModel> getInvoices({
    required int page,
    required int limit,
    String? search,
    String? status,
    String? timePeriod,
    String? paymentMethod,
    String? dateFrom,
    String? dateTo,
  }) async {
    final response = await apiConsumer.get(
      ApiConstants.invoices,
      queryParameters: {
        'page': page,
        'limit': limit,
        if (search != null && search.isNotEmpty) 'search': search,
        if (status != null && status.isNotEmpty) 'status': status,
        if (timePeriod != null && timePeriod.isNotEmpty) 'timePeriod': timePeriod,
        if (paymentMethod != null && paymentMethod.isNotEmpty) 'paymentMethod': paymentMethod,
        if (dateFrom != null && dateFrom.isNotEmpty) 'dateFrom': dateFrom,
        if (dateTo != null && dateTo.isNotEmpty) 'dateTo': dateTo,
      },
    );
    return FullInvoiceListModel.fromJson(response['data']);
  }

  @override
  Future<FullInvoiceModel> getInvoiceDetails(String id) async {
    final response = await apiConsumer.get(ApiConstants.invoiceDetails(id));
    return FullInvoiceModel.fromJson(response['data']);
  }
}