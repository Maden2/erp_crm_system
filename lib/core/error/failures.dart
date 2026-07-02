import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  final int? statusCode;

  const ServerFailure([
    String message = 'حدث خطأ في الاتصال بالسيرفر',
    this.statusCode,
  ]) : super(message);

  @override
  List<Object> get props => [message, statusCode ?? 0];
}

class NetworkFailure extends Failure {
  const NetworkFailure() : super('لا يوجد اتصال بالإنترنت');
}

class ParsingFailure extends Failure {
  const ParsingFailure() : super('خطأ في معالجة البيانات');
}