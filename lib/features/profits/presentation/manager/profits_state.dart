import '../../domain/entities/profit_entity.dart';

abstract class ProfitsState {}

class ProfitsInitial extends ProfitsState {}

class ProfitsLoading extends ProfitsState {}

class ProfitsSuccess extends ProfitsState {
  final ProfitEntity profitData;
  final String selectedTimeFrame;

  ProfitsSuccess({
    required this.profitData,
    this.selectedTimeFrame = "يومي",
  });
}

class ProfitsError extends ProfitsState {
  final String message;
  ProfitsError(this.message);
}