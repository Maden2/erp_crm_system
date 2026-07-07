import 'package:equatable/equatable.dart';
import '../../domain/entities/full_analytics_entity.dart';

abstract class FullAnalyticsState extends Equatable {
  const FullAnalyticsState();

  @override
  List<Object?> get props => [];
}

class FullAnalyticsInitial extends FullAnalyticsState {}

class FullAnalyticsLoading extends FullAnalyticsState {}

class FullAnalyticsSuccess extends FullAnalyticsState {
  final FullAnalyticsEntity analytics;

  const FullAnalyticsSuccess({required this.analytics});

  @override
  List<Object?> get props => [analytics];
}

class FullAnalyticsFailure extends FullAnalyticsState {
  final String message;

  const FullAnalyticsFailure({required this.message});

  @override
  List<Object?> get props => [message];
}