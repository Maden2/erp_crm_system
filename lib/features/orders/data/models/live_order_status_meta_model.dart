import '../../domain/entities/live_order_status_meta_entity.dart';

class LiveOrderStatusMetaModel extends LiveOrderStatusMetaEntity {
  const LiveOrderStatusMetaModel({
    required super.value,
    required super.label,
    required super.labelEn,
    required super.color,
    required super.bg,
  });

  factory LiveOrderStatusMetaModel.fromJson(Map<String, dynamic> json) {
    return LiveOrderStatusMetaModel(
      value: json['value'] as int,
      label: json['label'] as String,
      labelEn: json['labelEn'] as String,
      color: json['color'] as String,
      bg: json['bg'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'value': value,
      'label': label,
      'labelEn': labelEn,
      'color': color,
      'bg': bg,
    };
  }
}