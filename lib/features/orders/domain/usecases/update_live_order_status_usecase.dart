import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/live_orders_repository.dart';

class UpdateLiveOrderStatusUseCase {
  final LiveOrdersRepository repository;

  UpdateLiveOrderStatusUseCase(this.repository);

  Future<Either<Failure, Map<String, dynamic>>> call(String id, int status) {
    return repository.updateOrderStatus(id, status);
  }
}