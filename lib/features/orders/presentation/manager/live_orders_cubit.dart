import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_live_orders_usecase.dart';
import '../../domain/usecases/update_live_order_status_usecase.dart';
import 'live_orders_state.dart';

class LiveOrdersCubit extends Cubit<LiveOrdersState> {
  final GetLiveOrdersUseCase getLiveOrdersUseCase;
  final UpdateLiveOrderStatusUseCase updateLiveOrderStatusUseCase;

  LiveOrdersCubit({
    required this.getLiveOrdersUseCase,
    required this.updateLiveOrderStatusUseCase,
  }) : super(LiveOrdersInitial());

  List<dynamic> _allOrders = [];

  // جلب اللستة الرئيسية
  Future<void> getLiveOrders({String? statusTab, String? search}) async {
    emit(LiveOrdersLoading());
    int? statusCode;
    if (statusTab != null && statusTab != "الكل" && statusTab.isNotEmpty) {
      statusCode = _mapTabToStatusCode(statusTab);
    }

    final result = await getLiveOrdersUseCase.call(
      status: statusCode,
      search: search,
      page: 1,
      limit: 50,
    );

    result.fold(
          (failure) => emit(LiveOrdersFailure(message: failure.message)),
          (ordersList) {
        if (ordersList.isEmpty) {
          emit(LiveOrdersEmpty());
        } else {
          _allOrders = ordersList;
          emit(LiveOrdersSuccess(orders: ordersList));
        }
      },
    );
  }

  // 🟢 الميثود الجديدة لجلب تفاصيل الأوردر بالمنتجات لايف من السيرفر
  Future<void> getLiveOrderDetails({required String orderId}) async {
    emit(LiveOrderDetailsLoading()); // تأكد من إضافة الحالة دي في الـ States عندك

    // هنا بتنده الـ UseCase بتاعة الـ Details (لو مش موجودة انده الـ repositoryImpl علطول)
    // لتسهيل الربط الحين، هنفترض إن الـ UseCase بترجع الأوردر كامل بالمنتجات:
    final result = await getLiveOrdersUseCase.repository.getOrderDetails(orderId);

    result.fold(
          (failure) => emit(LiveOrderDetailsFailure(message: failure.message)),
          (detailedOrder) => emit(LiveOrderDetailsSuccess(order: detailedOrder)),
    );
  }

  Future<void> updateStatus(String orderId, int newStatus) async {
    emit(UpdateOrderStatusLoading());
    final result = await updateLiveOrderStatusUseCase.call(orderId, newStatus);
    result.fold(
          (failure) => emit(UpdateOrderStatusFailure(message: failure.message)),
          (successData) {
        emit(UpdateOrderStatusSuccess(orderId: orderId, newStatus: newStatus));
        getLiveOrderDetails(orderId: orderId); // إعادة جلب التفاصيل لتحديث الشاشة فوراً
      },
    );
  }

  int _mapTabToStatusCode(String tab) {
    switch (tab) {
      case "قيد الانتظار": return 0;
      case "تم الدفع": return 1;
      case "قيد الشحن": return 2;
      case "تم التوصيل": case "تم التسليم": return 3;
      case "ملغى": return 4;
      case "جاري التجهيز": return 5;
      case "مكتمل": return 6;
      case "مرتجع": return 7;
      case "فشل": return 8;
      default: return 0;
    }
  }
}