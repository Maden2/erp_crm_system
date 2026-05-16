import 'dart:math';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/entities/order_item_entity.dart';
import '../../domain/repositories/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  @override
  Future<Either<Failure, List<OrderEntity>>> getOrders({
    String? status,
    String? query,
  }) async {
    try {
      await Future.delayed(const Duration(milliseconds: 800));

      List<String> names = [
        "محمد أحمد مبارك", "محمود حسن", "إبراهيم علي", "سارة أحمد",
        "عمر خالد", "ليلى محمود", "ياسين محمد", "هاني شاكر", "منى زكي", "أحمد عز"
      ];

      List<OrderEntity> mockOrders = List.generate(20, (index) {
        final random = Random();
        String orderStatus = status ?? "جديد";

        if (status == "الكل" || status == null) {
          List<String> statuses = ["جديد", "قيد الشحن", "تم التسليم", "ملغى"];
          orderStatus = statuses[random.nextInt(4)];
        }

        return _createOrder(
          index.toString(),
          "#${28400 + index}",
          names[index % names.length],
          orderStatus,
          (random.nextInt(4000) + 500).toDouble(),
          random.nextInt(3) + 1,
        );
      });

      if (status != null && status != "الكل") {
        mockOrders = mockOrders.where((order) => order.status == status).toList();
      }

      if (query != null && query.isNotEmpty) {
        mockOrders = mockOrders.where((order) =>
        order.customerName.contains(query) ||
            order.orderNumber.contains(query)).toList();
      }

      return Right(mockOrders);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  OrderEntity _createOrder(String id, String num, String name, String status, double basePrice, int count) {
    final random = Random();

    List<OrderItemEntity> orderItems = List.generate(count, (index) {
      double productPrice = (random.nextInt(1000) + 200).toDouble();
      return OrderItemEntity(
        id: "prod_${id}_$index",
        name: "منتج تجريبي رقم ${index + 1}",
        image: "https://picsum.photos/seed/${id}_$index/100/100",
        quantity: random.nextInt(2) + 1,
        price: productPrice,
      );
    });

    double calculatedSubTotal = 0;
    for (var item in orderItems) {
      calculatedSubTotal += (item.price * item.quantity);
    }

    double shipping = 50.0;
    double tax = (calculatedSubTotal * 0.15);
    double discount = 150.0;

    double totalAmount = (calculatedSubTotal + shipping + tax) - discount;

    return OrderEntity(
      id: id,
      orderNumber: num,
      customerName: name,
      customerPhone: "+20 10${random.nextInt(90000000) + 10000000}",
      customerEmail: "user$id@pivot-app.com",
      shippingAddress: "كفر الشيخ، مركز دسوق، عمارة رقم ${random.nextInt(100)}",
      date: DateTime.now().subtract(Duration(days: random.nextInt(5), hours: random.nextInt(24))),

      items: orderItems,
      itemsCount: count,
      subTotal: calculatedSubTotal,
      shippingFees: shipping,
      tax: tax,
      discount: discount,
      totalAmount: totalAmount,
      status: status,
      paymentMethod: random.nextBool() ? "كاش" : "بطاقة ائتمانية",
      paymentStatus: status == "تم التسليم" ? "مدفوع" : "قيد الانتظار",
      invoiceNumber: "INV-2026-${1000 + int.parse(id)}",
      shippingCompany: "شركة الشحن السريع",
      trackingNumber: "TRK-${random.nextInt(900000)}",
      deliveryStatus: status == "قيد الشحن" ? "في الطريق" : "معلق",

      staffNotes: int.parse(id) % 2 == 0
          ? "يرجى الاتصال قبل التوصيل"
          : "",
    );
  }}