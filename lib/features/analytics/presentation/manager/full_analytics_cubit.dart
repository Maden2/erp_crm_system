import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_full_analytics_usecase.dart';
import 'full_analytics_state.dart';

class FullAnalyticsCubit extends Cubit<FullAnalyticsState> {
  final GetFullAnalyticsUseCase getFullAnalyticsUseCase;

  FullAnalyticsCubit({required this.getFullAnalyticsUseCase}) : super(FullAnalyticsInitial());

  /// 🟢 جلب التحليلات الشاملة بناءً على الفلاتر المحددة من الـ UI
  Future<void> getAnalytics({
    required String period,
    String? dateFrom,
    String? dateTo,
  }) async {
    emit(FullAnalyticsLoading());

    final result = await getFullAnalyticsUseCase.call(
      period: period,
      dateFrom: dateFrom,
      dateTo: dateTo,
    );

    result.fold(
          (failure) => emit(FullAnalyticsFailure(message: failure.message)),
          (analyticsData) => emit(FullAnalyticsSuccess(analytics: analyticsData)),
    );
  }
}