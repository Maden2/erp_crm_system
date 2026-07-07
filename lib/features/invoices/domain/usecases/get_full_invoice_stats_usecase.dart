import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart'; // تماشيًا مع مسار الـ core عندك
import '../entities/full_invoice_entities.dart';
import '../repositories/full_invoice_repository.dart';

class GetFullInvoiceStatsUseCase {
  final FullInvoiceRepository repository;

  GetFullInvoiceStatsUseCase(this.repository);

  Future<Either<Failure, FullInvoiceStatsEntity>> call() async {
    return await repository.getInvoiceStats();
  }
}