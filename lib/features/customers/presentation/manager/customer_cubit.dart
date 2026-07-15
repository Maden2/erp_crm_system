import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/customer_models.dart';
import '../../domain/entities/customer_entities.dart';
import 'customer_state.dart';

class CustomerCubit extends Cubit<CustomerState> {
  CustomerCubit() : super(CustomerInitial());

  // جلب قائمة العملاء (مع إمكانية تمرير فلتر)
  void fetchCustomers({bool isEmptyCase = false}) {
    emit(CustomerLoading());

    // محاكاة تأخير السيرفر
    Future.delayed(const Duration(milliseconds: 500), () {
      if (isEmptyCase) {
        emit(CustomerSuccess(
          customerList: const CustomerListEntity(totalCount: 0, activeCount: 0, customers: []),
        ));
      } else {
        emit(CustomerSuccess(
          customerList: MockCustomerData.mockCustomersList,
        ));
      }
    });
  }

  void fetchCustomerDetails(String customerId) {
    emit(CustomerLoading());

    Future.delayed(const Duration(milliseconds: 300), () {
      // 🟢 بنجيب التفاصيل ونمرر معاها لستة الموك كاملة عشان الـ Builder يقرأ الـ Success علطول
      final detail = MockCustomerData.mockDetails[customerId] ?? MockCustomerData.mockDetails["4"];
      emit(CustomerSuccess(
        customerList: MockCustomerData.mockCustomersList,
        selectedCustomerDetail: detail,
      ));
    });
  }}