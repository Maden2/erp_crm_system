import '../models/invoice_model.dart';
import '../../domain/entities/invoice_entity.dart';

abstract class InvoiceRemoteDataSource {
  Future<List<InvoiceModel>> getRemoteInvoices();
}

class InvoiceRemoteDataSourceImpl implements InvoiceRemoteDataSource {
  @override
  Future<List<InvoiceModel>> getRemoteInvoices() async {
    await Future.delayed(const Duration(milliseconds: 600));

    return [
      const InvoiceModel(
        invoiceNumber: "#INV-2483",
        date: "12 يناير 2025 - 3:42 م",
        status: InvoiceStatus.paid,
        subTotal: "ج.م 734,000",
        tax: "ج.م 109,115",
        totalAmount: "ج.م 843,215",
        paymentMethod: PaymentMethodEntity(
          methodName: "بطاقة ائتمان",
          paymentStatus: "تم الدفع بنجاح",
          isPaid: true,
        ),
        products: [
          InvoiceProductEntity(
            productName: "هاتف iPhone 17 Pro",
            quantity: 1,
            price: "ج.م 90,000",
          ),
          InvoiceProductEntity(
            productName: "Apple iPhone 16 Pro",
            quantity: 4,
            price: "ج.م 320,000",
          ),
          InvoiceProductEntity(
            productName: "iPhone 15 Plus",
            quantity: 6,
            price: "ج.م 324,000",
          ),
        ],
      ),
      const InvoiceModel(
        invoiceNumber: "#28473",
        date: "12 يناير 2025 - 3:42 م",
        status: InvoiceStatus.unpaid,
        subTotal: "ج.م 320,000",
        tax: "ج.م 48,000",
        totalAmount: "ج.م 368,000",
        paymentMethod: PaymentMethodEntity(
          methodName: "تحويل بنكي",
          paymentStatus: "بانتظار الدفع",
          isPaid: false,
        ),
        products: [
          InvoiceProductEntity(
            productName: "Apple iPhone 16 Pro",
            quantity: 4,
            price: "ج.م 320,000",
          ),
        ],
      ),
      const InvoiceModel(
        invoiceNumber: "#IVV-38474",
        date: "12 يناير 2025 - 3:42 م",
        status: InvoiceStatus.canceled,
        subTotal: "ج.م 320,000",
        tax: "ج.م 48,000",
        totalAmount: "ج.م 368,000",
        paymentMethod: PaymentMethodEntity(
          methodName: "دفع نقدي",
          paymentStatus: "بانتظار الدفع",
          isPaid: false,
        ),
        products: [
          InvoiceProductEntity(
            productName: "Apple iPhone 16 Pro",
            quantity: 4,
            price: "ج.م 320,000",
          ),
        ],
      ),
      const InvoiceModel(
        invoiceNumber: "#IVV-9999F",
        date: "20 يونيو 2026 - 8:50 م",
        status: InvoiceStatus.canceled,
        subTotal: "ج.م 90,000",
        tax: "ج.م 13,500",
        totalAmount: "ج.م 103,500",
        paymentMethod: PaymentMethodEntity(
          methodName: "بطاقة ائتمان",
          paymentStatus: "فشل الدفع - ملغاة",
          isPaid: false,
        ),
        products: [
          InvoiceProductEntity(
            productName: "هاتف iPhone 17 Pro",
            quantity: 1,
            price: "ج.م 90,000",
          ),
        ],
      ),
    ];
  }
}
