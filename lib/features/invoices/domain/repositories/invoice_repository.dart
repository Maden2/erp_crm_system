import 'package:dartz/dartz.dart';
import '../entities/invoice_entity.dart';

abstract class InvoiceRepository {
  Future<Either<String, List<InvoiceEntity>>> getInvoices();
}
