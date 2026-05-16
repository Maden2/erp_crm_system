import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_orders_usecase.dart';
import '../../domain/entities/order_entity.dart';
import 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  final GetOrdersUseCase getOrdersUseCase;
  OrdersCubit(this.getOrdersUseCase) : super(OrdersInitial());

  String selectedStatus = "جديد";
  List<OrderEntity> allOrders = [];
  String? searchQuery;

  void getOrders({String? status, String? query}) async {
    emit(OrdersLoading());

    selectedStatus = status ?? selectedStatus;
    searchQuery = query ?? searchQuery;

    final result = await getOrdersUseCase.call(
      status: selectedStatus,
      query: searchQuery,
    );

    result.fold(
          (failure) => emit(OrdersFailure(failure.message)),
          (orders) {
        allOrders = orders;
        if (orders.isEmpty) {
          emit(OrdersEmpty());
        } else {
          emit(OrdersSuccess(orders));
        }
      },
    );
  }

  void changeStatus(String status) {
    selectedStatus = status;
    emit(OrderStatusChanged(status));
    getOrders(status: status);
  }

  void searchOrders(String query) {
    getOrders(query: query);
  }
}