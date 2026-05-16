import 'package:equatable/equatable.dart';

class OrderItemEntity extends Equatable {
  final String id;
  final String name;
  final String image;
  final int quantity;
  final double price;

  const OrderItemEntity({
    required this.id,
    required this.name,
    required this.image,
    required this.quantity,
    required this.price,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    quantity,
    price,
  ];
}