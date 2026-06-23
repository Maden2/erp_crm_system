import '../../domain/entities/invoice_entity.dart';

abstract class InvoicesState {}

class InvoicesInitial extends InvoicesState {}

class InvoicesLoading extends InvoicesState {}

class InvoicesEmpty extends InvoicesState {}

class InvoicesSuccess extends InvoicesState {
  final List<InvoiceEntity> allInvoices;
  final List<InvoiceEntity> filteredInvoices;

  final InvoiceStatus? selectedStatus;
  final String selectedTimeFrame;
  final String selectedPaymentMethod;

  InvoicesSuccess({
    required this.allInvoices,
    required this.filteredInvoices,
    this.selectedStatus,
    this.selectedTimeFrame = "الكل",
    this.selectedPaymentMethod = "الكل",
  });
}

class InvoicesError extends InvoicesState {
  final String message;
  InvoicesError(this.message);
}
