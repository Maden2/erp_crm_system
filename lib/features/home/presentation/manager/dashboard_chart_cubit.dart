import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/dashboard_chart_point_entity.dart';
import '../../domain/usecases/get_dashboard_chart_use_case.dart';

part 'dashboard_chart_state.dart';

class DashboardChartCubit extends Cubit<DashboardChartState> {
  final GetDashboardChartUseCase getDashboardChartUseCase;

  DashboardChartCubit(this.getDashboardChartUseCase) : super(DashboardChartInitial());

  String currentPeriod = "month";

  Future<void> loadDashboardChart({required String period}) async {
    currentPeriod = period;
    emit(DashboardChartLoading());

    final result = await getDashboardChartUseCase(period: period);

    result.fold(
          (failure) => emit(DashboardChartError(message: failure.message)),
          (data) => emit(DashboardChartSuccess(chartPoints: data, selectedPeriod: currentPeriod)),
    );
  }
}