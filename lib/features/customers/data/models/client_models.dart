import '../../domain/entities/client_entities.dart';

// ================== 1. CUSTOMER STATS MODEL ==================
class ClientStatsModel extends ClientStatsEntity {
  const ClientStatsModel({
    required super.totalCustomers,
    required super.growthRate,
    required super.activeCustomers,
    required super.activePercentage,
  });

  factory ClientStatsModel.fromJson(Map<String, dynamic> json) {
    final int total = json['totalCustomers'] ?? 0;
    final int active = json['activeCustomers'] ?? 0;

    // حساب النسبة المئوية للنشطين مانيوال كـ Fallback لو السيرفر مرجعهاش
    final String activePercent = total > 0
        ? "${((active / total) * 100).toInt()}%"
        : "0%";

    return ClientStatsModel(
      totalCustomers: total,
      growthRate: json['growthRate'] ?? "+8%", // Fallback كقيمة افتراضية جمالية
      activeCustomers: active,
      activePercentage: json['activePercentage'] ?? activePercent,
    );
  }
}

// ================== 2. CUSTOMER LIST ITEM MODEL ==================
class ClientListItemModel extends ClientListItemEntity {
  const ClientListItemModel({
    required super.id,
    required super.name,
    required super.ordersCount,
    required super.totalSpent,
    super.logoUrl,
  });

  factory ClientListItemModel.fromJson(Map<String, dynamic> json) {
    return ClientListItemModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      ordersCount: json['ordersCount'] ?? 0,
      totalSpent: (json['totalSpent'] as num?)?.toDouble() ?? 0.0,
      logoUrl: json['logoUrl'] ?? json['avatar'], // دعم قراءة avatar من السيرفر مباشرة
    );
  }
}

// ================== 3. CUSTOMER DETAIL MODEL ==================
class ClientDetailModel extends ClientDetailEntity {
  const ClientDetailModel({
    required super.id,
    required super.name,
    required super.isActive,
    required super.phone,
    required super.email,
    required super.registrationDate,
    required super.rating,
    super.note,
    required super.totalOrders,
    required super.totalSpending,
    required super.averageOrderValue,
    required super.orders,
  });

  factory ClientDetailModel.fromJson(Map<String, dynamic> json) {
    // 🟢 استخراج الكائنات المتداخلة من الـ JSON الحقيقي اللي راجع م السيرفر
    final profile = json['profile'] as Map<String, dynamic>? ?? {};
    final analytics = json['analytics'] as Map<String, dynamic>? ?? {};

    // قراءة سجل الطلبات من recentOrders المتطابق مع السيرفر
    var list = json['recentOrders'] as List? ?? [];
    List<ClientOrderHistoryEntity> ordersList = list.map((i) => ClientOrderHistoryModel.fromJson(i)).toList();

    // تنسيق تاريخ التسجيل القادم من profile
    String rawDate = profile['CustomerSince']?.toString() ?? '';
    String formattedDate = rawDate.length > 10 ? rawDate.substring(0, 10) : rawDate;

    return ClientDetailModel(
      id: json['Id']?.toString() ?? json['id']?.toString() ?? '',
      name: json['FullName'] ?? json['name'] ?? '',
      isActive: true, // السيرفر بيرجع العميل بنجاح إذاً هو نشط
      phone: json['PhoneNumber'] ?? json['phone'] ?? '',
      email: json['Email'] ?? json['email'] ?? '',
      registrationDate: formattedDate,
      rating: (json['averageRating'] as num?)?.toDouble() ?? 4.3,
      note: profile['AdminNotes'] ?? json['note'],
      totalOrders: analytics['OrdersCount'] ?? 0,
      totalSpending: (analytics['TotalSpent'] as num?)?.toDouble() ?? 0.0,
      averageOrderValue: (analytics['AverageOrderValue'] as num?)?.toDouble() ?? 0.0,
      orders: ordersList,
    );
  }
}

// ================== 4. CUSTOMER ORDER HISTORY MODEL ==================
class ClientOrderHistoryModel extends ClientOrderHistoryEntity {
  const ClientOrderHistoryModel({
    required super.orderId,
    required super.date,
    required super.amount,
    required super.statusLabel,
  });

  factory ClientOrderHistoryModel.fromJson(Map<String, dynamic> json) {
    // تنسيق تاريخ الطلب القادم من السيرفر
    String rawDate = json['OrderDate'] ?? json['date'] ?? '';
    String formattedDate = rawDate.length > 10 ? rawDate.substring(0, 10) : rawDate;

    return ClientOrderHistoryModel(
      orderId: json['OrderNumber'] ?? json['orderId'] ?? json['Id']?.toString() ?? '',
      date: formattedDate,
      amount: (json['TotalAmount'] as num?)?.toDouble() ?? (json['amount'] as num?)?.toDouble() ?? 0.0,
      statusLabel: json['Status'] == 1 ? "تم التوصيل" : "قيد الانتظار", // هاندلة الحالة بناءً على كود الـ API
    );
  }
}