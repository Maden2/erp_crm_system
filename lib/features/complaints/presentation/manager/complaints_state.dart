import '../../domain/entities/complaint_entities.dart';

abstract class ComplaintsState {}

class ComplaintsInitial extends ComplaintsState {}

class ComplaintsLoading extends ComplaintsState {}

class ComplaintsSuccess extends ComplaintsState {
  final ComplaintListContainerEntity container;
  final ComplaintDetailEntity? selectedDetail;

  ComplaintsSuccess({
    required this.container,
    this.selectedDetail,
  });
}

class ComplaintsError extends ComplaintsState {
  final String message;
  ComplaintsError(this.message);
}