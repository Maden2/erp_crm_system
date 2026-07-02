import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';

// 🟢 الـ Imports الجديدة (الـ Dashboard الواقعي)
import '../entities/dashboard_home_entity.dart';
import '../entities/dashboard_chart_point_entity.dart'; // ✅ الاسم الجديد النظيف بدون hide

// ⚪ الـ Imports القديمة (من غير hide عشان مفيش تضارب خلاص)
import '../entities/latest_support_ticket_entity.dart';
import '../entities/sales_chart_entity.dart';
import '../entities/low_stock_entity.dart';

abstract class HomeRepository {
  // ================= 🟢 الدوال الجديدة (الـ Dashboard) =================

  Future<Either<Failure, DashboardHomeEntity>> getDashboardHome({
    required String period,
  });

  Future<Either<Failure, List<DashboardChartPointEntity>>> getSalesChart({
    required String period,
  });

  // ================= ⚪ الدوال القديمة (سيبناها زي ما هي) =================

  Future<Either<Failure, List<SalesChartPointEntity>>> getSalesChartOld({
    required String filter,
  });

  Future<Either<Failure, List<LowStockEntity>>> getLowStockProducts();

  Future<Either<Failure, LatestSupportTicketEntity?>> getLatestSupportTicket();
}