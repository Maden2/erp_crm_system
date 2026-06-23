import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/latest_support_ticket_entity.dart';
import '../entities/sales_chart_entity.dart';
import '../entities/low_stock_entity.dart';

abstract class HomeRepository {
  //  Sales Chart
  Future<Either<Failure, List<SalesChartPointEntity>>> getSalesChart({
    required String filter,
  });

  //  Low Stock Products
  Future<Either<Failure, List<LowStockEntity>>> getLowStockProducts();

  //  Latest Support Ticket
  Future<Either<Failure, LatestSupportTicketEntity?>> getLatestSupportTicket();
}
