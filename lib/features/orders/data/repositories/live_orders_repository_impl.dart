import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/live_order_entity.dart';
import '../../domain/entities/live_order_status_meta_entity.dart';
import '../../domain/repositories/live_orders_repository.dart';
import '../datasources/live_orders_remote_data_source.dart';

class LiveOrdersRepositoryImpl implements LiveOrdersRepository {
  final LiveOrdersRemoteDataSource remoteDataSource;

  LiveOrdersRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<LiveOrderEntity>>> getOrders({int? status, String? search, int? page, int? limit}) async {
    try {
      final remoteOrders = await remoteDataSource.getOrders(
        status: status,
        search: search,
        page: page,
        limit: limit,
      );
      return Right(remoteOrders);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, LiveOrderEntity>> getOrderDetails(String id) async {
    try {
      final remoteDetail = await remoteDataSource.getOrderDetails(id);
      return Right(remoteDetail);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<LiveOrderStatusMetaEntity>>> getOrderStatuses() async {
    try {
      final remoteStatuses = await remoteDataSource.getOrderStatuses();
      return Right(remoteStatuses);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Map<String, dynamic>>>> getOrderSummary() async {
    try {
      final remoteSummary = await remoteDataSource.getOrderSummary();
      return Right(remoteSummary);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> updateOrderStatus(String id, int status) async {
    try {
      final result = await remoteDataSource.updateOrderStatus(id, status);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}