import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/ticket_usecases.dart';
import 'ticket_state.dart';

class TicketCubit extends Cubit<TicketState> {
  final GetTicketsListUseCase getTicketsListUseCase;
  final GetTicketDetailsUseCase getTicketDetailsUseCase;
  final UpdateTicketStatusUseCase updateTicketStatusUseCase;
  final CreateTestimonialUseCase createTestimonialUseCase;

  TicketCubit({
    required this.getTicketsListUseCase,
    required this.getTicketDetailsUseCase,
    required this.updateTicketStatusUseCase,
    required this.createTestimonialUseCase,
  }) : super(TicketInitial());

  // 1. جلب قائمة الشكاوى والإحصائيات
  Future<void> fetchTickets({String? status, String? dateFilter, String? search}) async {
    emit(TicketLoading());
    try {
      final result = await getTicketsListUseCase(
        status: status,
        dateFilter: dateFilter,
        search: search,
      );

      emit(TicketSuccess(
        tickets: result['items'],
        stats: result['stats'],
      ));
    } catch (e) {
      emit(TicketError(e.toString()));
    }
  }

  // 2. جلب تفاصيل شكوى معينة
  Future<void> fetchTicketDetails(String id) async {
    emit(TicketDetailsLoading());
    try {
      final details = await getTicketDetailsUseCase(id);
      emit(TicketSuccess(selectedTicket: details));
    } catch (e) {
      emit(TicketError(e.toString()));
    }
  }

  // 3. تحديث حالة الشكوى (Open / Closed)
  Future<void> updateStatus(String id, String newStatus) async {
    emit(TicketStatusUpdating());
    try {
      await updateTicketStatusUseCase(id, newStatus);
      // إعادة جلب التفاصيل أو اللستة بعد التحديث للتأكيد
      await fetchTicketDetails(id);
    } catch (e) {
      emit(TicketError(e.toString()));
    }
  }

  // 4. إضافة تقييم جديد (Testimonial)
  Future<void> addTestimonial({required String name, required int rating, required String comment}) async {
    emit(TestimonialCreating());
    try {
      await createTestimonialUseCase(name: name, rating: rating, comment: comment);
      emit(TicketSuccess(message: "تم إضافة التقييم بنجاح"));
    } catch (e) {
      emit(TicketError(e.toString()));
    }
  }
}