import 'package:dartz/dartz.dart';
import '../entities/invoice_entity.dart';
import '../repositories/invoice_repository.dart';

class GetInvoicesUseCase {
  final InvoiceRepository repository;

  GetInvoicesUseCase(this.repository);

  Future<Either<String, List<InvoiceEntity>>> call() async {
    return await repository.getInvoices();
  }
}
