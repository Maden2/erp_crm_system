import '../../domain/entities/greeting_entity.dart';

class GreetingModel extends GreetingEntity {
  const GreetingModel({
    required super.fullName,
    required super.message,
  });

  factory GreetingModel.fromJson(Map<String, dynamic> json) {
    return GreetingModel(
      fullName: json['fullName'] ?? '',
      message: json['message'] ?? '',
    );
  }
}