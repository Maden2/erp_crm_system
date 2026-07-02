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

  // لستة للحفاظ على الداتا في الذاكرة لو احتجنا فلترة سريعة
  List<dynamic> _allOrders = [];

  // 🟢 ميثود جلب الطلبات لايف مع تحويل الـ Tabs لنظام السيرفر (int)
  Future<void> getLiveOrders({String? statusTab, String? search}) async {
    emit(LiveOrdersLoading());

    // تحويل مسمى الـ Tab العربي لرقم الـ Status المطابق في السيرفر (0 - 8)
    int? statusCode;
    if (statusTab != null && statusTab != "الكل") {
      statusCode = _mapTabToStatusCode(statusTab);
    }

    final result = await getLiveOrdersUseCase.call(
      status: statusCode,
      search: search,
      page: 1, // البداية بالصفحة الأولى دائمًا
      limit: 50, // جلب لستة كافية للعرض
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

  // 🟢 ميثود تحديث حالة الطلب لايف (PATCH)
  Future<void> updateStatus(String orderId, int newStatus) async {
    emit(UpdateOrderStatusLoading());

    final result = await updateLiveOrderStatusUseCase.call(orderId, newStatus);

    result.fold(
          (failure) => emit(UpdateOrderStatusFailure(message: failure.message)),
          (successData) {
        emit(UpdateOrderStatusSuccess(orderId: orderId, newStatus: newStatus));
        // إعادة جلب الداتا لتحديث الشاشة تلقائيًا بعد التعديل
        getLiveOrders();
      },
    );
  }

  // دالة مساعدة ذكية لتحويل الـ Tabs لـ الأكواد المطلوبة في السيرفر
  int _mapTabToStatusCode(String tab) {
    switch (tab) {
      case "قيد الانتظار": return 0;
      case "تم الدفع": return 1;
      case "قيد الشحن": return 2;
      case "تم التوصيل": return 3;
      case "ملغى": return 4;
      case "جاري التجهيز": return 5;
      case "مكتمل": return 6;
      case "مرتجع": return 7;
      case "فشل": return 8;
      default: return 0;
    }
  }
}