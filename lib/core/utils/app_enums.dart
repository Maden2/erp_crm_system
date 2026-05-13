import 'package:flutter/material.dart';

enum StockStatus {
  available,
  discounted,
  lowStock,
}

extension StockStatusX on StockStatus {
  String get label {
    switch (this) {
      case StockStatus.available:
        return 'متوفر';
      case StockStatus.discounted:
        return 'مخفض';
      case StockStatus.lowStock:
        return 'مستنفد قريباً';
    }
  }

  Color get color {
    switch (this) {
      case StockStatus.available:
        return const Color(0xFF4CAF50);
      case StockStatus.discounted:
        return const Color(0xFFF59E0B);
      case StockStatus.lowStock:
        return const Color(0xFFEF4444);
    }
  }
}