part of 'low_stock_cubit.dart';

abstract class LowStockState {}

class LowStockInitial extends LowStockState {}

class LowStockLoading extends LowStockState {}

class LowStockSuccess extends LowStockState {
  final List<LowStockEntity> data;

  LowStockSuccess(this.data);
}

class LowStockError extends LowStockState {
  final String message;

  LowStockError(this.message);
}