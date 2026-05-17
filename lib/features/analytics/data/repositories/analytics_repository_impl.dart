import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/analytics_entity.dart';
import '../../domain/repositories/analytics_repository.dart';

class AnalyticsRepositoryImpl implements AnalyticsRepository {
  @override
  Future<Either<Failure, AnalyticsEntity>> getAnalytics() async {
    await Future.delayed(const Duration(seconds: 1));

    return Right(
      AnalyticsEntity(
        totalSalesToday: 248000,
        salesChangePercentage: 0.66,
        salesChart: [
          ChartDataEntity('السبت', 1.5),
          ChartDataEntity('الأحد', 1.2),
          ChartDataEntity('الاثنين', 2.8),
          ChartDataEntity('الثلاثاء', 2.2),
          ChartDataEntity('الأربعاء', 3.4),
          ChartDataEntity('الخميس', 2.6),
          ChartDataEntity('الجمعة', 3.0),
        ],

        netProfit: 124000,
        netProfitChangePercentage: -1.07,
        netProfitChart: [
          ChartDataEntity('السبت', 3.0),
          ChartDataEntity('الأحد', 2.5),
          ChartDataEntity('الاثنين', 3.2),
          ChartDataEntity('الثلاثاء', 2.8),
          ChartDataEntity('الأربعاء', 2.2),
          ChartDataEntity('الخميس', 1.8),
          ChartDataEntity('الجمعة', 1.5),
        ],

        totalOrders: 1240,
        ordersChangePercentage: 0.45,
        ordersChart: [
          ChartDataEntity('السبت', 1.0),
          ChartDataEntity('الأحد', 2.5),
          ChartDataEntity('الاثنين', 1.5),
          ChartDataEntity('الثلاثاء', 3.0),
          ChartDataEntity('الأربعاء', 2.0),
          ChartDataEntity('الخميس', 3.5),
          ChartDataEntity('الجمعة', 2.8),
        ],

        cancellationRate: 4.66,
        cancellationChangePercentage: -4.66,
        cancellationChart: [
          ChartDataEntity('السبت', 2.0),
          ChartDataEntity('الأحد', 3.0),
          ChartDataEntity('الاثنين', 2.5),
          ChartDataEntity('الثلاثاء', 3.5),
          ChartDataEntity('الأربعاء', 2.8),
          ChartDataEntity('الخميس', 3.2),
          ChartDataEntity('الجمعة', 2.4),
        ],

        topProducts: [
          TopProductEntity(
            name: 'منتج 1',
            image: 'assets/images/placeholder.png',
            salesCount: 320,
            totalRevenue: 64000,
          ),
          TopProductEntity(
            name: 'منتج 2',
            image: 'assets/images/placeholder.png',
            salesCount: 210,
            totalRevenue: 42000,
          ),
          TopProductEntity(
            name: 'منتج 3',
            image: 'assets/images/placeholder.png',
            salesCount: 180,
            totalRevenue: 36000,
          ),
        ],

        categoryPerformance: [
          CategoryPerformanceEntity('هةاتف', 95),
          CategoryPerformanceEntity('اكسسوار', 85),
          CategoryPerformanceEntity('ملابس', 49),
        ],
      ),
    );
  }
}