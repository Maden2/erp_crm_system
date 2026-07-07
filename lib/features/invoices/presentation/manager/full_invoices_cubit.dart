import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/full_invoice_entities.dart';
import '../../domain/usecases/get_full_invoice_details_usecase.dart';
import '../../domain/usecases/get_full_invoice_stats_usecase.dart';
import '../../domain/usecases/get_full_invoice_statuses_usecase.dart';
import '../../domain/usecases/get_full_invoices_usecase.dart';
import 'full_invoices_state.dart';

class FullInvoicesCubit extends Cubit<FullInvoicesState> {
  final GetFullInvoicesUseCase getFullInvoicesUseCase;
  final GetFullInvoiceStatsUseCase getFullInvoiceStatsUseCase; // 🟩 متصلحة بالملي بدون es
  final GetFullInvoiceStatusesUseCase getFullInvoiceStatusesUseCase; // 🟩 متصلحة بالملي بـ es
  final GetFullInvoiceDetailsUseCase getFullInvoiceDetailsUseCase;

  FullInvoicesCubit({
    required this.getFullInvoicesUseCase,
    required this.getFullInvoiceStatsUseCase,
    required this.getFullInvoiceStatusesUseCase,
    required this.getFullInvoiceDetailsUseCase,
  }) : super(FullInvoicesInitial());

  var _cachedDefinitions = const <FullInvoiceStatusDefinitionEntity>[];

  /// 🟢 جلب البيانات الأساسية (تُستدعى عند فتح الشاشة لأول مرة)
  Future<void> fetchInitialInvoiceData({
    int page = 1,
    int limit = 20,
    String? search,
    String? status,
    String? timePeriod,
    String? paymentMethod,
    String? dateFrom,
    String? dateTo,
  }) async {
    emit(FullInvoicesLoading());

    final statusesResult = await getFullInvoiceStatusesUseCase.call();
    final statsResult = await getFullInvoiceStatsUseCase.call();
    final invoicesResult = await getFullInvoicesUseCase.call(
      page: page,
      limit: limit,
      search: search,
      status: status,
      timePeriod: timePeriod,
      paymentMethod: paymentMethod,
      dateFrom: dateFrom,
      dateTo: dateTo,
    );

    statusesResult.fold(
          (failure) => emit(FullInvoicesFailure(message: failure.message)),
          (definitions) {
        _cachedDefinitions = definitions;
        statsResult.fold(
              (failure) => emit(FullInvoicesFailure(message: failure.message)),
              (stats) {
            invoicesResult.fold(
                  (failure) => emit(FullInvoicesFailure(message: failure.message)),
                  (invoiceList) => emit(FullInvoicesSuccess(
                invoiceList: invoiceList,
                invoiceStats: stats,
                statusDefinitions: _cachedDefinitions,
              )),
            );
          },
        );
      },
    );
  }

  /// 🟢 دالة الفلترة والـ Pagination السريعة (تحدث اللستة فقط مع الحفاظ على الكاش الفوقاني)
  Future<void> fetchInvoicesFiltered({
    required int page,
    int limit = 20,
    String? search,
    String? status,
    String? timePeriod,
    String? paymentMethod,
    String? dateFrom,
    String? dateTo,
  }) async {
    final statsResult = await getFullInvoiceStatsUseCase.call();
    final invoicesResult = await getFullInvoicesUseCase.call(
      page: page,
      limit: limit,
      search: search,
      status: status,
      timePeriod: timePeriod,
      paymentMethod: paymentMethod,
      dateFrom: dateFrom,
      dateTo: dateTo,
    );

    statsResult.fold(
          (failure) => emit(FullInvoicesFailure(message: failure.message)),
          (stats) {
        invoicesResult.fold(
              (failure) => emit(FullInvoicesFailure(message: failure.message)),
              (invoiceList) => emit(FullInvoicesSuccess(
            invoiceList: invoiceList,
            invoiceStats: stats,
            statusDefinitions: _cachedDefinitions,
          )),
        );
      },
    );
  }

  /// 🟢 جلب تفاصيل الفاتورة الكاملة (لشاشة تفاصيل الفاتورة)
  Future<void> fetchInvoiceDetails(String id) async {
    emit(FullInvoiceDetailsLoading());

    final result = await getFullInvoiceDetailsUseCase.call(id);

    result.fold(
          (failure) => emit(FullInvoiceDetailsFailure(message: failure.message)),
          (details) => emit(FullInvoiceDetailsSuccess(invoiceDetail: details)),
    );
  }
}