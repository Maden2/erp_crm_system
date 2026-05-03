import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/sales_chart_entity.dart';
import '../../domain/entities/low_stock_entity.dart';
import '../../domain/entities/latest_support_ticket_entity.dart'; // ✅ مهم
import '../../domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {

  // ================== Sales Chart ==================
  @override
  Future<Either<Failure, List<SalesChartPointEntity>>> getSalesChart({
    required String filter,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));

    return Right(_generateData(filter));
  }

  List<SalesChartPointEntity> _generateData(String filter) {
    switch (filter) {
      case "1أ":
        return List.generate(
          6,
              (i) => SalesChartPointEntity(
            index: i,
            dayName: ["السبت","الأحد","الاثنين","الثلاثاء","الأربعاء","الخميس"][i],
            value: (i + 1) * 1000 + (i.isEven ? 500 : -300),
          ),
        );

      case "1ش":
        return [
          SalesChartPointEntity(index: 0, dayName: "أسبوع 1", value: 2000),
          SalesChartPointEntity(index: 1, dayName: "أسبوع 2", value: 4500),
          SalesChartPointEntity(index: 2, dayName: "أسبوع 3", value: 2800),
          SalesChartPointEntity(index: 3, dayName: "أسبوع 4", value: 5200),
        ];

      case "3ش":
        return List.generate(
          3,
              (i) => SalesChartPointEntity(
            index: i,
            dayName: ["يناير","فبراير","مارس"][i],
            value: (i + 1) * 4000 + (i.isEven ? 1200 : -800),
          ),
        );

      case "6ش":
        return List.generate(
          6,
              (i) => SalesChartPointEntity(
            index: i,
            dayName: "شهر ${i + 1}",
            value: (i + 1) * 2500 + (i.isEven ? 1000 : -500),
          ),
        );

      case "1س":
        return List.generate(
          12,
              (i) => SalesChartPointEntity(
            index: i,
            dayName: "شهر ${i + 1}",
            value: (i + 1) * 1800 + (i.isEven ? 1500 : -700),
          ),
        );

      case "الكل":
        return List.generate(
          5,
              (i) => SalesChartPointEntity(
            index: i,
            dayName: "سنة ${2020 + i}",
            value: (i + 1) * 10000 + (i.isEven ? 4000 : -3000),
          ),
        );

      default:
        return [];
    }
  }

  // ================== Low Stock ==================
  @override
  Future<Either<Failure, List<LowStockEntity>>> getLowStockProducts() async {
    await Future.delayed(const Duration(milliseconds: 300));

    final mockItems = [
      LowStockEntity(
        id: "1",
        productName: "قهوة إثيوبية مختصة",
        categoryName: "منتجات قهوة",
        remainingQuantity: 3,
        imageUrl: "https://picsum.photos/200",
      ),
      LowStockEntity(
        id: "2",
        productName: "قهوة كولومبية ذهبية",
        categoryName: "منتجات قهوة",
        remainingQuantity: 5,
        imageUrl: "https://picsum.photos/201",
      ),
      LowStockEntity(
        id: "3",
        productName: "حقيبة تحمل حرارية",
        categoryName: "إكسسوارات المتجر",
        remainingQuantity: 2,
        imageUrl: "https://picsum.photos/202",
      ),
    ];

    return Right(mockItems);
  }

  // ================== Support Ticket ==================
  @override
  Future<Either<Failure, LatestSupportTicketEntity?>> getLatestSupportTicket() async {
    await Future.delayed(const Duration(milliseconds: 300));

    return Right(
      LatestSupportTicketEntity(
        ticketNumber: "#2483",
        timeAgo: "قبل 3 ساعات",
      ),
    );
  }
}