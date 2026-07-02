import '../../domain/entities/live_order_entity.dart';

abstract class LiveOrdersState {
  const LiveOrdersState();
}

class LiveOrdersInitial extends LiveOrdersState {}

class LiveOrdersLoading extends LiveOrdersState {}

class LiveOrdersSuccess extends LiveOrdersState {
  final List<LiveOrderEntity> orders;

  LiveOrdersSuccess({required this.orders});
}

class LiveOrdersEmpty extends LiveOrdersState {}

class LiveOrdersFailure extends LiveOrdersState {
  final String message;


  LiveOrdersFailure({required this.message});
}

// ================== الحالات الـ Live لتحديث الـ Status (PATCH) ==================
class UpdateOrderStatusLoading extends LiveOrdersState {}

class UpdateOrderStatusSuccess extends LiveOrdersState {
  final String orderId;
  final int newStatus;
  UpdateOrderStatusSuccess({required this.orderId, required this.newStatus});
}

class UpdateOrderStatusFailure extends LiveOrdersState {
  final String message;
  UpdateOrderStatusFailure({required this.message});
}