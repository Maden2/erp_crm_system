import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/product_details_entity.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/entities/product_filter_entity.dart';
import '../../domain/entities/warehouse_history_entity.dart';
import '../../domain/repositories/product_repository.dart';
import '../models/product_details_model.dart';

class ProductRepositoryImpl implements ProductRepository {

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts({
    String? query,
    String? warehouseId,
    ProductFilterEntity? filter,
  }) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));

      List<ProductEntity> data = [];

      for (int i = 1; i <= 20; i++) {
        String category = (i % 2 == 0) ? "هواتف" : "إكسسوار";

        if (warehouseId == "2" && category != "هواتف") continue;
        if (warehouseId == "3" && category != "إكسسوار") continue;

        int quantity = (i % 7 == 0)
            ? 0
            : (i % 4 == 0 ? 3 : 15);

        data.add(
          ProductEntity(
            id: "$i",
            name: category == "هواتف"
                ? "آيفون 16 برو ماكس إصدار $i"
                : "سماعة لاسلكية عازلة $i",

            price: "${(i * 1200) + 5000}",

            image:
            "https://picsum.photos/200/200?random=$i",

            quantity: quantity,

            category: category,

            isLowStock:
            quantity > 0 && quantity <= 5,

            sku: "SKU-PVT-$i",
          ),
        );
      }

      // ================= FILTER =================

      if (filter != null) {

        // CATEGORY
        if (filter.category != null &&
            filter.category!.isNotEmpty &&
            filter.category != "الكل") {

          data = data.where(
                (p) => p.category == filter.category,
          ).toList();
        }

        // STOCK STATUS
        if (filter.stockStatus == "نفاد") {

          data = data.where(
                (p) => p.quantity == 0,
          ).toList();

        } else if (filter.stockStatus == "منخفض") {

          data = data.where(
                (p) => p.isLowStock,
          ).toList();

        } else if (filter.stockStatus == "مستقر") {

          data = data.where(
                (p) =>
            !p.isLowStock &&
                p.quantity > 0,
          ).toList();
        }

        // MIN PRICE
        if (filter.minPrice != null) {

          data = data.where((p) {
            final price =
                double.tryParse(p.price) ?? 0;

            return price >= filter.minPrice!;
          }).toList();
        }

        // MAX PRICE
        if (filter.maxPrice != null) {

          data = data.where((p) {
            final price =
                double.tryParse(p.price) ?? 0;

            return price <= filter.maxPrice!;
          }).toList();
        }
      }

      // ================= SEARCH =================

      if (query != null && query.isNotEmpty) {

        data = data.where(
              (product) =>
              product.name
                  .toLowerCase()
                  .contains(query.toLowerCase()),
        ).toList();
      }

      return Right(data);

    } catch (e) {

      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProductDetailsEntity>>
  getProductDetails(String productId) async {

    try {

      await Future.delayed(
        const Duration(milliseconds: 400),
      );

      int id = int.tryParse(productId) ?? 1;

      bool isPhone = id % 2 == 0;

      return Right(
        ProductDetailsModel(
          id: productId,

          name: isPhone
              ? "آيفون 16 برو ماكس إصدار $id"
              : "سماعة لاسلكية عازلة $id",

          price: "${(id * 1200) + 5000}",

          sku: "SKU-PVT-$id",

          brand: isPhone
              ? "Apple"
              : "Generic",

          stock: (id % 7 == 0)
              ? 0
              : (id % 4 == 0 ? 3 : 15),

          warranty: 12,

          description: isPhone
              ? "يأتي هذا الهاتف بتصميم فاخر من التيتانيوم مع كاميرا احترافية ومعالج قوي."
              : "سماعة بلوتوث احترافية توفر صوتاً نقياً مع عزل ضوضاء وبطارية تدوم طويلاً.",

          images: [
            "https://picsum.photos/400/400?random=$id",

            "https://picsum.photos/400/400?random=${id + 100}",

            "https://picsum.photos/400/400?random=${id + 200}",
          ],

          colors: isPhone
              ? [
            0xFF1C1C1C,
            0xFFE5E5E5,
            0xFFD4AF37,
          ]
              : [
            0xFF000000,
            0xFFFFFFFF,
            0xFF708090,
          ],

          sizes: isPhone
              ? ["128GB", "256GB", "512GB"]
              : ["One Size"],

          priceHistory: List.generate(
            7,
                (index) {

              double base =
              isPhone ? 50000.0 : 1000.0;

              double variation =
                  (id * (index + 1) * 37) % 5000;

              return base +
                  variation +
                  (index * 100);
            },
          ),

          category: isPhone
              ? "هواتف"
              : "إكسسوار",

          minOrder: 1,
        ),
      );

    } catch (e) {

      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>>
  copyProductToWarehouse({
    required String productId,
    required String warehouseId,
  }) async {

    try {

      await Future.delayed(
        const Duration(seconds: 1),
      );

      return const Right(unit);

    } catch (e) {

      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure,
      List<WarehouseHistoryEntity>>>
  getWarehouseHistory() async {

    try {

      await Future.delayed(
        const Duration(milliseconds: 500),
      );

      final List<WarehouseHistoryEntity>
      history = [

        WarehouseHistoryEntity(
          id: "1",
          userName: "صالح أحمد",
          date: "4/4/2025 04:54",
          productsCount: 21,
          category: "ساعات",
        ),

        WarehouseHistoryEntity(
          id: "2",
          userName: "مريم محمد",
          date: "4/4/2025 04:54",
          productsCount: 21,
          category: "ساعات",
        ),
      ];

      return Right(history);

    } catch (e) {

      return Left(ServerFailure(e.toString()));
    }
  }
}