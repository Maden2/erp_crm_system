part of 'dashboard_chart_cubit.dart';

abstract class DashboardChartState {}

class DashboardChartInitial extends DashboardChartState {}

class DashboardChartLoading extends DashboardChartState {}

class DashboardChartSuccess extends DashboardChartState {
  final List<DashboardChartPointEntity> chartPoints;
  final String selectedPeriod;
  DashboardChartSuccess({required this.chartPoints, required this.selectedPeriod});
}

class DashboardChartError extends DashboardChartState {
  final String message;
  DashboardChartError({required this.message});
}