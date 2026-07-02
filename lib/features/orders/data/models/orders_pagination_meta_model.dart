import '../../domain/entities/orders_pagination_meta_entity.dart';

class OrdersPaginationMetaModel extends OrdersPaginationMetaEntity {
  const OrdersPaginationMetaModel({
    required super.total,
    required super.page,
    required super.limit,
  });

  factory OrdersPaginationMetaModel.fromJson(Map<String, dynamic> json) {
    return OrdersPaginationMetaModel(
      total: json['total'] as int,
      page: json['page'] as int,
      limit: json['limit'] as int,
    );
  }
}