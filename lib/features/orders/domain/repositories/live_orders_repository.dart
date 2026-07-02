import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/live_order_entity.dart';
import '../../domain/entities/live_order_status_meta_entity.dart';

abstract class LiveOrdersRepository {
  Future<Either<Failure, List<LiveOrderEntity>>> getOrders({int? status, String? search, int? page, int? limit});
  Future<Either<Failure, LiveOrderEntity>> getOrderDetails(String id);
  Future<Either<Failure, List<LiveOrderStatusMetaEntity>>> getOrderStatuses();
  Future<Either<Failure, List<Map<String, dynamic>>>> getOrderSummary();
  Future<Either<Failure, Map<String, dynamic>>> updateOrderStatus(String id, int status);
}