import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/full_invoice_entities.dart';
import '../repositories/full_invoice_repository.dart';

class GetFullInvoicesUseCase {
  final FullInvoiceRepository repository;

  GetFullInvoicesUseCase(this.repository);

  Future<Either<Failure, FullInvoiceListEntity>> call({
    required int page,
    required int limit,
    String? search,
    String? status,
    String? timePeriod,
    String? paymentMethod,
    String? dateFrom,
    String? dateTo,
  }) async {
    return await repository.getInvoices(
      page: page,
      limit: limit,
      search: search,
      status: status,
      timePeriod: timePeriod,
      paymentMethod: paymentMethod,
      dateFrom: dateFrom,
      dateTo: dateTo,
    );
  }
}