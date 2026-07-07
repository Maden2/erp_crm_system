import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/full_invoice_entities.dart';
import '../repositories/full_invoice_repository.dart';

class GetFullInvoiceStatusesUseCase {
  final FullInvoiceRepository repository;

  GetFullInvoiceStatusesUseCase(this.repository);

  Future<Either<Failure, List<FullInvoiceStatusDefinitionEntity>>> call() async {
    return await repository.getInvoiceStatuses();
  }
}