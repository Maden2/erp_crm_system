import '../../domain/entities/analytics_entity.dart';

abstract class AnalyticsState {}

class AnalyticsInitial extends AnalyticsState {}

class AnalyticsLoading extends AnalyticsState {}

class AnalyticsSuccess extends AnalyticsState {
  final AnalyticsEntity analytics;
  AnalyticsSuccess(this.analytics);
}

class AnalyticsError extends AnalyticsState {
  final String message;
  AnalyticsError(this.message);
}
