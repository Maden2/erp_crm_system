import '../../domain/entities/complaint_entities.dart';

class MockComplaintData {
  static const ComplaintListContainerEntity mockContainer = ComplaintListContainerEntity(
    totalCount: 12,
    openCount: 4,
    closedCount: 8,
    closeRatePercent: 67,
    complaints: [
      ComplaintItemEntity(id: "1", customerName: "أحمد محمد", title: "تأخير في الشحن", date: "12 يناير 2025", statusLabel: "مفتوحة"),
      ComplaintItemEntity(id: "2", customerName: "سارة علي", title: "منتج وصل تالف", date: "14 يناير 2025", statusLabel: "مغلقة"),
      ComplaintItemEntity(id: "3", customerName: "محمد حسين", title: "خطأ في الفاتورة", date: "20 يناير 2025", statusLabel: "مفتوحة"),
      ComplaintItemEntity(id: "4", customerName: "نور خالد", title: "تأخير في استرجاع المبلغ", date: "22 يناير 2025", statusLabel: "مغلقة"),
      ComplaintItemEntity(id: "5", customerName: "عبدالله سالم", title: "مشكلة في طريقة الدفع", date: "22 يناير 2025", statusLabel: "مغلقة"),
    ],
  );

  static final Map<String, ComplaintDetailEntity> mockDetails = {
    "2": const ComplaintDetailEntity(
      infoCard: ComplaintItemEntity(id: "2", customerName: "سارة علي", title: "منتج وصل تالف", date: "14 يناير 2025", statusLabel: "مغلقة"),
      fullDescription: "استلمت الطلب ولكن المنتج كان تالفًا وغير صالح للاستخدام. أتمنى مراجعة المشكلة واتخاذ الإجراء المناسب في أقرب وقت.",
      orderNumber: "#24591",
      productName: "حقيبة يد نسائية",
      orderDate: "8 يناير 2025",
    ),
  };
}