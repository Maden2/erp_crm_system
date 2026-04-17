import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

// خطأ من طرف السيرفر (API Error)
class ServerFailure extends Failure {
  const ServerFailure([String message = 'حدث خطأ في الاتصال بالسيرفر']) : super(message);
}

// خطأ بسبب الإنترنت (No Internet)
class NetworkFailure extends Failure {
  const NetworkFailure() : super('لا يوجد اتصال بالإنترنت');
}

// خطأ في معالجة البيانات (Parsing JSON)
class ParsingFailure extends Failure {
  const ParsingFailure() : super('خطأ في معالجة البيانات');
}