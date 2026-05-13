import '../../domain/entities/warehouse_history_entity.dart';

abstract class WarehouseHistoryState {}

class WarehouseHistoryInitial extends WarehouseHistoryState {}

class WarehouseHistoryLoading extends WarehouseHistoryState {}

class WarehouseHistorySuccess extends WarehouseHistoryState {
  final List<WarehouseHistoryEntity> history;
  WarehouseHistorySuccess(this.history);
}

class WarehouseHistoryFailure extends WarehouseHistoryState {
  final String message;
  WarehouseHistoryFailure(this.message);
}