import 'package:flutter_bloc/flutter_bloc.dart';
import 'invoices_state.dart';
import '../../domain/usecases/get_invoices_use_case.dart';
import '../../domain/entities/invoice_entity.dart';

class InvoicesCubit extends Cubit<InvoicesState> {
  final GetInvoicesUseCase getInvoicesUseCase;

  InvoicesCubit({required this.getInvoicesUseCase}) : super(InvoicesInitial());

  void fetchInvoices({bool forceEmpty = false}) async {
    emit(InvoicesLoading());
    if (forceEmpty) {
      emit(InvoicesEmpty());
      return;
    }

    final result = await getInvoicesUseCase();
    result.fold((failure) => emit(InvoicesError(failure)), (invoices) {
      if (invoices.isEmpty) {
        emit(InvoicesEmpty());
      } else {
        emit(
          InvoicesSuccess(allInvoices: invoices, filteredInvoices: invoices),
        );
      }
    });
  }

  void searchInvoices(String query) {
    if (state is InvoicesSuccess) {
      final currentState = state as InvoicesSuccess;
      if (query.isEmpty) {
        emit(
          InvoicesSuccess(
            allInvoices: currentState.allInvoices,
            filteredInvoices: currentState.allInvoices,
            selectedStatus: currentState.selectedStatus,
            selectedTimeFrame: currentState.selectedTimeFrame,
            selectedPaymentMethod: currentState.selectedPaymentMethod,
          ),
        );
        return;
      }
      final filtered = currentState.allInvoices.where((invoice) {
        return invoice.invoiceNumber.toLowerCase().contains(
          query.toLowerCase(),
        );
      }).toList();

      emit(
        InvoicesSuccess(
          allInvoices: currentState.allInvoices,
          filteredInvoices: filtered,
          selectedStatus: currentState.selectedStatus,
          selectedTimeFrame: currentState.selectedTimeFrame,
          selectedPaymentMethod: currentState.selectedPaymentMethod,
        ),
      );
    }
  }

  void filterInvoices({
    InvoiceStatus? status,
    String timeFrame = "الكل",
    String paymentMethod = "الكل",
  }) {
    if (state is InvoicesSuccess) {
      final currentState = state as InvoicesSuccess;

      List<InvoiceEntity> filtered = currentState.allInvoices;

      if (status != null) {
        filtered = filtered
            .where((invoice) => invoice.status == status)
            .toList();
      }

      if (timeFrame != "الكل") {
        if (timeFrame == "اليوم") {
          filtered = filtered
              .where((invoice) => invoice.date.contains("2026"))
              .toList();
        } else if (timeFrame == "هذا الشهر") {
          filtered = filtered
              .where(
                (invoice) =>
                    invoice.date.contains("يونيو") ||
                    invoice.date.contains("يناير"),
              )
              .toList();
        }
      }

      if (paymentMethod != "الكل") {
        filtered = filtered.where((invoice) {
          final method = invoice.paymentMethod.methodName;
          if (paymentMethod == "بطاقة") return method.contains("بطاقة");
          if (paymentMethod == "تحويل") return method.contains("تحويل");
          if (paymentMethod == "نقدي")
            return method.contains("نقدي") || method.contains("كاش");
          return true;
        }).toList();
      }

      emit(
        InvoicesSuccess(
          allInvoices: currentState.allInvoices,
          filteredInvoices: filtered,
          selectedStatus: status,
          selectedTimeFrame: timeFrame,
          selectedPaymentMethod: paymentMethod,
        ),
      );
    }
  }
}
