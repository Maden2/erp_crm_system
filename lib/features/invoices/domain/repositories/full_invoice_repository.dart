import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/full_invoice_entities.dart';

abstract class FullInvoiceRepository {
  // 1. حالات الفواتير للـ Filter Chips
  Future<Either<Failure, List<FullInvoiceStatusDefinitionEntity>>> getInvoiceStatuses();

  // 2. إحصائيات الفواتير للكروت الفوقانية
  Future<Either<Failure, FullInvoiceStatsEntity>> getInvoiceStats();

  // 3. لستة الفواتير مع الفلاتر والبحث والـ Pagination
  Future<Either<Failure, FullInvoiceListEntity>> getInvoices({
    required int page,
    required int limit,
    String? search,
    String? status,
    String? timePeriod,
    String? paymentMethod,
    String? dateFrom,
    String? dateTo,
  });

  // 4. تفاصيل الفاتورة الكاملة بالبند المالي
  Future<Either<Failure, FullInvoiceDetailEntity>> getInvoiceDetails(String id);
}