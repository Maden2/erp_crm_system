import '../../domain/entities/live_order_entity.dart';

abstract class LiveOrdersState {
  const LiveOrdersState();
}

class LiveOrdersInitial extends LiveOrdersState {}

class LiveOrdersLoading extends LiveOrdersState {}

class LiveOrdersSuccess extends LiveOrdersState {
  final List<LiveOrderEntity> orders;

  const LiveOrdersSuccess({required this.orders});
}

class LiveOrdersEmpty extends LiveOrdersState {}

class LiveOrdersFailure extends LiveOrdersState {
  final String message;

  const LiveOrdersFailure({required this.message});
}

// ================== الحالات الـ Live لتحديث الـ Status (PATCH) ==================
class UpdateOrderStatusLoading extends LiveOrdersState {}

class UpdateOrderStatusSuccess extends LiveOrdersState {
  final String orderId;
  final int newStatus;
  const UpdateOrderStatusSuccess({required this.orderId, required this.newStatus});
}

class UpdateOrderStatusFailure extends LiveOrdersState {
  final String message;
  const UpdateOrderStatusFailure({required this.message});
}

// 🟢 الحالات الجديدة الخاصة بتفاصيل الأوردر الفردي والمنتجات
class LiveOrderDetailsLoading extends LiveOrdersState {}

class LiveOrderDetailsSuccess extends LiveOrdersState {
  final LiveOrderEntity order;

  const LiveOrderDetailsSuccess({required this.order});
}

class LiveOrderDetailsFailure extends LiveOrdersState {
  final String message;

  const LiveOrderDetailsFailure({required this.message});
}