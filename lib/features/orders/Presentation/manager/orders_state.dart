import 'package:equatable/equatable.dart';
import '../../domain/entities/order_entity.dart';

abstract class OrdersState extends Equatable {
  const OrdersState();

  @override
  List<Object?> get props => [];
}

class OrdersInitial extends OrdersState {}

class OrdersLoading extends OrdersState {}

class OrdersSuccess extends OrdersState {
  final List<OrderEntity> orders;
  const OrdersSuccess(this.orders);

  @override
  List<Object?> get props => [orders];
}

class OrdersFailure extends OrdersState {
  final String message;
  const OrdersFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class OrdersEmpty extends OrdersState {}

class OrderStatusChanged extends OrdersState {
  final String status;
  const OrderStatusChanged(this.status);

  @override
  List<Object?> get props => [status];
}