import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/full_invoice_entities.dart';
import '../repositories/full_invoice_repository.dart';

class GetFullInvoiceDetailsUseCase {
  final FullInvoiceRepository repository;

  GetFullInvoiceDetailsUseCase(this.repository);

  Future<Either<Failure, FullInvoiceDetailEntity>> call(String id) async {
    return await repository.getInvoiceDetails(id);
  }
}