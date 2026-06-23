part of 'sales_chart_cubit.dart';

abstract class SalesChartState {}

class SalesChartInitial extends SalesChartState {}

class SalesChartLoading extends SalesChartState {}

class SalesChartSuccess extends SalesChartState {
  final List<SalesChartPointEntity> data;
  final String selectedFilter;

  SalesChartSuccess(this.data, this.selectedFilter);
}

class SalesChartError extends SalesChartState {
  final String message;

  SalesChartError(this.message);
}
