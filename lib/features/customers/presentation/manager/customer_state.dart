import '../../domain/entities/customer_entities.dart';

abstract class CustomerState {}

class CustomerInitial extends CustomerState {}

class CustomerLoading extends CustomerState {}

class CustomerSuccess extends CustomerState {
  final CustomerListEntity customerList;
  final CustomerDetailEntity? selectedCustomerDetail;

  CustomerSuccess({
    required this.customerList,
    this.selectedCustomerDetail,
  });
}

class CustomerError extends CustomerState {
  final String message;
  CustomerError(this.message);
}