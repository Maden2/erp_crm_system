import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/api_constants.dart';
import '../models/dashboard_home_model.dart';
import '../models/dashboard_chart_point_model.dart'; // ✅ الـ Import المظبوط للاسم الجديد النظيف

abstract class HomeRemoteDataSource {
  // ريكويست بيجيب داتا الشاشة كاملة (KPIs, Profit, Low Stock, Notifications...)
  Future<DashboardHomeModel> getDashboardHome({required String period});

  // ريكويست مخصص لتحديث الـ Chart بس لما المستخدم يغير الفلتر (يوم، أسبوع، شهر...)
  Future<List<DashboardChartPointModel>> getSalesChart({required String period});
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final ApiConsumer apiConsumer;

  HomeRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<DashboardHomeModel> getDashboardHome({required String period}) async {
    final response = await apiConsumer.get(
      ApiConstants.dashboardHome,
      queryParameters: {'period': period},
    );
    // بنباصي الـ data اللي راجعة للـ FromJson بتاعة الموديل الكبير
    return DashboardHomeModel.fromJson(response['data'] ?? response);
  }

  @override
  Future<List<DashboardChartPointModel>> getSalesChart({required String period}) async {
    final response = await apiConsumer.get(
      ApiConstants.salesChart,
      queryParameters: {'period': period},
    );

    // بنجيب لستة الـ chart ونعمل ليها map للموديل الجديد بتاعنا
    final List chartList = response['data']?['chart'] ?? response['chart'] ?? [];
    return chartList.map((e) => DashboardChartPointModel.fromJson(e)).toList();
  }
}