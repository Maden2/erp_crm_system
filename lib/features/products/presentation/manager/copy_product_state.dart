import 'package:equatable/equatable.dart';

abstract class CopyProductState extends Equatable {
  const CopyProductState();

  @override
  List<Object?> get props => [];
}

class CopyProductInitial extends CopyProductState {}

class CopyProductLoading extends CopyProductState {}

class CopyProductSuccess extends CopyProductState {}

class CopyProductFailure extends CopyProductState {
  final String message;
  const CopyProductFailure(this.message);

  @override
  List<Object?> get props => [message];
}
