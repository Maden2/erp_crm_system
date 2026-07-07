import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/full_invoice_repository.dart';
import '../datasources/full_invoice_remote_data_source.dart';
import '../models/full_invoice_models.dart';

class FullInvoiceRepositoryImpl implements FullInvoiceRepository {
  final FullInvoiceRemoteDataSource remoteDataSource;

  FullInvoiceRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<FullInvoiceStatusDefinitionModel>>> getInvoiceStatuses() async {
    try {
      final result = await remoteDataSource.getInvoiceStatuses();
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.message));
    }
  }

  @override
  Future<Either<Failure, FullInvoiceStatsModel>> getInvoiceStats() async {
    try {
      final result = await remoteDataSource.getInvoiceStats();
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.message));
    }
  }

  @override
  Future<Either<Failure, FullInvoiceListModel>> getInvoices({
    required int page,
    required int limit,
    String? search,
    String? status,
    String? timePeriod,
    String? paymentMethod,
    String? dateFrom,
    String? dateTo,
  }) async {
    try {
      final result = await remoteDataSource.getInvoices(
        page: page,
        limit: limit,
        search: search,
        status: status,
        timePeriod: timePeriod,
        paymentMethod: paymentMethod,
        dateFrom: dateFrom,
        dateTo: dateTo,
      );
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.message));
    }
  }

  @override
  Future<Either<Failure, FullInvoiceModel>> getInvoiceDetails(String id) async {
    try {
      final result = await remoteDataSource.getInvoiceDetails(id);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.message));
    }
  }
}