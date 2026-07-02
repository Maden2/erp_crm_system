import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/home_repository.dart';

// 🟢 الـ Imports الجديدة بتاعة الـ Dashboard الواقعي
import '../../domain/entities/dashboard_home_entity.dart';
import '../../domain/entities/dashboard_chart_point_entity.dart'; // ✅ الاسم الجديد
import '../datasources/home_remote_data_source.dart';

// ⚪ الـ Imports القديمة (بالـ prefix لمنع أي تداخل مع الكلاسات القديمة)
import '../../domain/entities/sales_chart_entity.dart' as old_ent;
import '../../domain/entities/low_stock_entity.dart' as old_ent;
import '../../domain/entities/latest_support_ticket_entity.dart' as old_ent;

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl({required this.remoteDataSource});

  // ================= 🟢 الدوال الجديدة (الـ Dashboard الحقيقي من السيرفر) =================

  @override
  Future<Either<Failure, DashboardHomeEntity>> getDashboardHome({
    required String period,
  }) async {
    try {
      final remoteData = await remoteDataSource.getDashboardHome(period: period);
      return Right(remoteData);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<DashboardChartPointEntity>>> getSalesChart({
    required String period,
  }) async {
    try {
      final remoteData = await remoteDataSource.getSalesChart(period: period);
      return Right(remoteData);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  // ================= ⚪ الدوال القديمة (الـ Mock Data مستقرة 100%) =================

  @override
  Future<Either<Failure, List<old_ent.SalesChartPointEntity>>> getSalesChartOld({
    required String filter,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return Right(_generateData(filter));
  }

  List<old_ent.SalesChartPointEntity> _generateData(String filter) {
    switch (filter) {
      case "1أ":
        return List.generate(
          6,
              (i) => old_ent.SalesChartPointEntity(
            index: i,
            dayName: ["السبت", "الأحد", "الاثنين", "الثلاثاء", "الأربعاء", "الخميس"][i],
            value: (i + 1) * 1000 + (i.isEven ? 500 : -300),
          ),
        );
      case "1ش":
        return [
          old_ent.SalesChartPointEntity(index: 0, dayName: "أسبوع 1", value: 2000),
          old_ent.SalesChartPointEntity(index: 1, dayName: "أسبوع 2", value: 4500),
          old_ent.SalesChartPointEntity(index: 2, dayName: "أسبوع 3", value: 2800),
          old_ent.SalesChartPointEntity(index: 3, dayName: "أسبوع 4", value: 5200),
        ];
      case "3ش":
        return List.generate(
          3,
              (i) => old_ent.SalesChartPointEntity(
            index: i,
            dayName: ["يناير", "فبراير", "مارس"][i],
            value: (i + 1) * 4000 + (i.isEven ? 1200 : -800),
          ),
        );
      case "6ش":
        return List.generate(
          6,
              (i) => old_ent.SalesChartPointEntity(
            index: i,
            dayName: "شهر ${i + 1}",
            value: (i + 1) * 2500 + (i.isEven ? 1000 : -500),
          ),
        );
      case "1س":
        return List.generate(
          12,
              (i) => old_ent.SalesChartPointEntity(
            index: i,
            dayName: "شهر ${i + 1}",
            value: (i + 1) * 1800 + (i.isEven ? 1500 : -700),
          ),
        );
      case "الكل":
        return List.generate(
          5,
              (i) => old_ent.SalesChartPointEntity(
            index: i,
            dayName: "سنة ${2020 + i}",
            value: (i + 1) * 10000 + (i.isEven ? 4000 : -3000),
          ),
        );
      default:
        return [];
    }
  }

  @override
  Future<Either<Failure, List<old_ent.LowStockEntity>>> getLowStockProducts() async {
    await Future.delayed(const Duration(milliseconds: 300));
    final mockItems = [
      old_ent.LowStockEntity(
        id: "1",
        productName: "قهوة إثيوبية مختصة",
        categoryName: "منتجات قهوة",
        remainingQuantity: 3,
        imageUrl: "https://picsum.photos/200",
      ),
      old_ent.LowStockEntity(
        id: "2",
        productName: "قهوة كولومبية ذهبية",
        categoryName: "منتجات قهوة",
        remainingQuantity: 5,
        imageUrl: "https://picsum.photos/201",
      ),
      old_ent.LowStockEntity(
        id: "3",
        productName: "حقيبة تحمل حرارية",
        categoryName: "إكسسوارات المتجر",
        remainingQuantity: 2,
        imageUrl: "https://picsum.photos/202",
      ),
    ];
    return Right(mockItems);
  }

  @override
  Future<Either<Failure, old_ent.LatestSupportTicketEntity?>> getLatestSupportTicket() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return Right(
      old_ent.LatestSupportTicketEntity(ticketNumber: "#2483", timeAgo: "قبل 3 ساعات"),
    );
  }
}