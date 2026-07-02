part of 'dashboard_home_cubit.dart';


abstract class DashboardHomeState {}

class DashboardHomeInitial extends DashboardHomeState {}

class DashboardHomeLoading extends DashboardHomeState {}

class DashboardHomeSuccess extends DashboardHomeState {
  final DashboardHomeEntity dashboardData;
  DashboardHomeSuccess({required this.dashboardData});
}

class DashboardHomeError extends DashboardHomeState {
  final String message;
  DashboardHomeError({required this.message});
}