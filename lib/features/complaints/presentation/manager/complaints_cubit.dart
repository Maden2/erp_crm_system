import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/complaint_models.dart';
import 'complaints_state.dart';

class ComplaintsCubit extends Cubit<ComplaintsState> {
  ComplaintsCubit() : super(ComplaintsInitial());

  void fetchComplaints() {
    emit(ComplaintsLoading());
    Future.delayed(const Duration(milliseconds: 300), () {
      emit(ComplaintsSuccess(
        container: MockComplaintData.mockContainer,
      ));
    });
  }

  // 🟢 التعديل هنا: جعل الدالة مستقلة وتجلب الموك مباشرة دون اشتراط الـ State السابقة
  void fetchComplaintDetails(String id) {
    emit(ComplaintsLoading());

    Future.delayed(const Duration(milliseconds: 250), () {
      // بنجيب التفاصيل بناءً على الـ id أو نرجع العنصر الافتراضي "2" للموك
      final detail = MockComplaintData.mockDetails[id] ?? MockComplaintData.mockDetails["2"]!;

      emit(ComplaintsSuccess(
        container: MockComplaintData.mockContainer, // نمرر الـ container الأساسي دايماً
        selectedDetail: detail,
      ));
    });
  }
}