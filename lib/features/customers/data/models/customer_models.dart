import '../../domain/entities/customer_entities.dart';

class CustomerItemModel extends CustomerItemEntity {
  const CustomerItemModel({
    required super.id,
    required super.name,
    required super.orderCount,
    required super.totalSpending,
    super.logoUrl,
    required super.isCompany,
  });

  factory CustomerItemModel.fromJson(Map<String, dynamic> json) {
    return CustomerItemModel(
      id: json['Id'] ?? json['id'] ?? '',
      name: json['Name'] ?? json['name'] ?? '',
      orderCount: json['OrderCount'] ?? json['orderCount'] ?? 0,
      totalSpending: (json['TotalSpending'] ?? json['totalSpending'] ?? 0).toDouble(),
      logoUrl: json['LogoUrl'] ?? json['logoUrl'],
      isCompany: json['IsCompany'] ?? json['isCompany'] ?? false,
    );
  }
}

// ==================== MOCK DATA STORE ====================
class MockCustomerData {
  static const CustomerListEntity mockCustomersList = CustomerListEntity(
    totalCount: 128,
    activeCount: 94,
    customers: [
      CustomerItemEntity(
        id: "1",
        name: "شركة النور التجارية",
        orderCount: 12,
        totalSpending: 54900,
        isCompany: true,
      ),
      CustomerItemEntity(
        id: "2",
        name: "مؤسسة الرواد",
        orderCount: 9,
        totalSpending: 18000,
        isCompany: true,
      ),
      CustomerItemEntity(
        id: "3",
        name: "متجر السعادة",
        orderCount: 2,
        totalSpending: 2500,
        isCompany: false,
      ),
      CustomerItemEntity(
        id: "4",
        name: "عيسى أحمد الشرقاوي",
        orderCount: 42,
        totalSpending: 200000,
        isCompany: false,
      ),
    ],
  );

  static final Map<String, CustomerDetailEntity> mockDetails = {
    "4": const CustomerDetailEntity(
      id: "4",
      name: "عيسى أحمد الشرقاوي",
      typeLabel: "عميل فردي",
      totalOrders: 42,
      totalPurchases: 200000,
      averageOrderValue: 8000,
      rating: 4.5,
      phone: "+201012344567",
      email: "ahmed@example.com",
      registrationDate: "12 فبراير 2023",
      deliveryNotes: "يرجى الاتصال قبل التوصيل",
      orderHistory: [
        CustomerOrderEntity(orderId: "o1", orderNumber: "#15024", date: "25 سبتمبر 2024", amount: 15000, statusLabel: "تم التوصيل"),
        CustomerOrderEntity(orderId: "o2", orderNumber: "#14112", date: "12 سبتمبر 2024", amount: 10000, statusLabel: "قيد التنفيذ"),
        CustomerOrderEntity(orderId: "o3", orderNumber: "#13521", date: "30 أغسطس 2024", amount: 35200, statusLabel: "تم التوصيل"),
      ],
    ),
  };
}