import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/dashboard_home_entity.dart';
import '../repositories/home_repository.dart';

class GetDashboardHomeUseCase {
  final HomeRepository repository;

  GetDashboardHomeUseCase(this.repository);

  Future<Either<Failure, DashboardHomeEntity>> call({required String period}) async {
    return await repository.getDashboardHome(period: period);
  }
}