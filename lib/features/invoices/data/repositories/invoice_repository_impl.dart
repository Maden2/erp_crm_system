import 'package:dartz/dartz.dart';
import '../../domain/entities/invoice_entity.dart';
import '../../domain/repositories/invoice_repository.dart';
import '../datasources/invoice_remote_data_source.dart';

class InvoiceRepositoryImpl implements InvoiceRepository {
  final InvoiceRemoteDataSource remoteDataSource;

  InvoiceRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<String, List<InvoiceEntity>>> getInvoices() async {
    try {
      final remoteData = await remoteDataSource.getRemoteInvoices();
      return Right(remoteData);
    } catch (e) {
      return Left("فشل في جلب البيانات: ${e.toString()}");
    }
  }
}
