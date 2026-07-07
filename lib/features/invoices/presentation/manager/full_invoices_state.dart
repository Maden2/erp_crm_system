import 'package:equatable/equatable.dart';
import '../../domain/entities/full_invoice_entities.dart';

abstract class FullInvoicesState extends Equatable {
  const FullInvoicesState();

  @override
  List<Object?> get props => [];
}

// --- حالات قائمة الفواتير والإحصائيات ---
class FullInvoicesInitial extends FullInvoicesState {}

class FullInvoicesLoading extends FullInvoicesState {}

class FullInvoicesSuccess extends FullInvoicesState {
  final FullInvoiceListEntity invoiceList;
  final FullInvoiceStatsEntity invoiceStats;
  final List<FullInvoiceStatusDefinitionEntity> statusDefinitions;

  const FullInvoicesSuccess({
    required this.invoiceList,
    required this.invoiceStats,
    required this.statusDefinitions,
  });

  @override
  List<Object?> get props => [invoiceList, invoiceStats, statusDefinitions];
}

class FullInvoicesFailure extends FullInvoicesState {
  final String message;

  const FullInvoicesFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

// --- حالات تفاصيل الفاتورة الفردية (Invoice Details) ---
class FullInvoiceDetailsLoading extends FullInvoicesState {}

class FullInvoiceDetailsSuccess extends FullInvoicesState {
  final FullInvoiceDetailEntity invoiceDetail;

  const FullInvoiceDetailsSuccess({required this.invoiceDetail});

  @override
  List<Object?> get props => [invoiceDetail];
}

class FullInvoiceDetailsFailure extends FullInvoicesState {
  final String message;

  const FullInvoiceDetailsFailure({required this.message});

  @override
  List<Object?> get props => [message];
}