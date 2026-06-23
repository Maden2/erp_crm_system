part of 'more_cubit.dart';

abstract class MoreState {}

class MoreInitial extends MoreState {}

class MoreProfileLoading extends MoreState {}

class MoreProfileSuccess extends MoreState {
  final CompanyEntity company;
  MoreProfileSuccess(this.company);
}

class MoreProfileError extends MoreState {
  final String message;
  MoreProfileError(this.message);
}

class MoreLogoutLoading extends MoreState {}

class MoreLogoutSuccess extends MoreState {}

class MoreLogoutError extends MoreState {
  final String message;
  MoreLogoutError(this.message);
}
