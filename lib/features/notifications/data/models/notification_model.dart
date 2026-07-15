import '../../domain/entities/notification_entity.dart';

class MockNotificationData {
  static final List<NotificationEntity> mockNotifications = [
    const NotificationEntity(
      id: "1",
      title: "طلب جديد",
      body: "تم استلام طلب جديد رقم #2451",
      createdAt: "منذ 10 دقائق",
      type: "new_order",
      isRead: false,
    ),
    const NotificationEntity(
      id: "2",
      title: "مخزون منخفض",
      body: "المنتج \"سماعة بلوتوث\" أوشك على النفاد",
      createdAt: "منذ ساعتين",
      type: "low_stock",
      isRead: false,
    ),
    const NotificationEntity(
      id: "3",
      title: "دعم فني جديد",
      body: "تم فتح تذكرة دعم جديدة من أحمد حسن",
      createdAt: "منذ 3 ساعات",
      type: "info",
      isRead: true,
    ),
    const NotificationEntity(
      id: "4",
      title: "مبيعات مرتفعة",
      body: "تحقق من أعلى المنتجات أداءً خلال اليوم",
      createdAt: "اليوم",
      type: "sales",
      isRead: false,
    ),
    const NotificationEntity(
      id: "5",
      title: "تحديث من النظام",
      body: "تم تحديث إعدادات الشحن",
      createdAt: "أمس",
      type: "system",
      isRead: true,
    ),
    const NotificationEntity(
      id: "6",
      title: "مخزون منخفض",
      body: "المنتج \"سماعة بلوتوث\" أوشك على النفاد",
      createdAt: "أمس",
      type: "low_stock",
      isRead: false,
    ),
    const NotificationEntity(
      id: "7",
      title: "طلب جديد",
      body: "تم استلام طلب جديد رقم #2461",
      createdAt: "أمس",
      type: "new_order",
      isRead: false,
    ),
  ];
}