import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pivot/core/utils/app_colors.dart';
import 'package:pivot/core/utils/app_styles.dart';
import '../../../../app/app_routes.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/widgets/app_add_button.dart';
import '../../../../core/widgets/custom_bottom_sheet_selector.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../domain/entities/warehouse_entity.dart';
import '../manager/products_cubit.dart';
import '../manager/products_state.dart';
import '../widgets/empty_products_widget.dart';
import '../widgets/warehouse_filter_header.dart';
import '../widgets/products_categories_tab_bar.dart';
import '../widgets/low_stock_alert_card.dart';
import '../widgets/products_list.dart';
import '../widgets/filter_bottom_sheet.dart';
import '../widgets/products_search_delegate.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _tabs = ["جميع الفئات", "هواتف", "إكسسوار"];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _showFilterBottomSheet(BuildContext rootContext) {
    final cubit = rootContext.read<ProductsCubit>();
    showModalBottomSheet(
      context: rootContext,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => FilterBottomSheet(
        initialFilter: cubit.currentFilter,
        onApply: (newFilter) => cubit.applyFilter(newFilter),
        onReset: () => cubit.clearFilter(),
      ),
    );
  }

  void _showWarehouseBottomSheet(BuildContext rootContext) {
    final cubit = rootContext.read<ProductsCubit>();
    showModalBottomSheet(
      context: rootContext,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => CustomBottomSheetSelector<WarehouseEntity>(
        title: "اختر المخزون",
        subTitle: "اختر مخزوناً لعرض منتجاته، أو اختر \"لا يوجد مخزون\" لرؤية المنتجات بدون تعيين.",
        items: [
          WarehouseEntity(id: "1", name: "لا يوجد مخزون", icon: Icons.inventory_2_outlined),
          WarehouseEntity(id: "2", name: "إلكترونيات", icon: Icons.inventory_2_outlined),
          WarehouseEntity(id: "3", name: "ملابس", icon: Icons.inventory_2_outlined),
        ],
        itemBuilder: (warehouse) => InkWell(
          onTap: () {
            cubit.filterByWarehouse(warehouse);
            Navigator.pop(context);
          },
          child: Container(
            margin: EdgeInsets.only(bottom: 12.h),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            decoration: BoxDecoration(
              color: cubit.selectedWarehouseId == warehouse.id
                  ? const Color(0xFFF0FDFA)
                  : const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: cubit.selectedWarehouseId == warehouse.id
                    ? const Color(0xFF2DD4BF)
                    : const Color(0xFFE2E8F0),
              ),
            ),
            child: Row(
              children: [
                Icon(warehouse.icon, color: const Color(0xFF2DD4BF), size: 20.sp),
                const Spacer(),
                Text(warehouse.name,
                    style: const TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProductsCubit>()..getProducts(),
      child: Builder(
          builder: (context) {
            return Scaffold(
              backgroundColor: AppColors.homeBg,
              appBar: CustomAppBar(
                leading: IconButton(
                  icon: const Icon(Icons.tune, color: Colors.white),
                  onPressed: () => _showFilterBottomSheet(context),
                ),
                title: Text(
                  "المنتجات",
                  style: TextStyles.font18WhiteBold.copyWith(fontFamily: 'Cairo'),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.search, color: Colors.white),
                    onPressed: () {
                      showSearch(
                        context: context,
                        delegate: ProductsSearchDelegate((query) {
                          context.read<ProductsCubit>().searchProducts(query);
                        }),
                      );
                    },
                  ),
                  SizedBox(width: 8.w),
                ],
              ),

              floatingActionButton: AppAddButton(
                title: "إضافة منتج",
                onTap: () {
                  print("إضافة منتج جديد");
                },
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

              body: Column(
                children: [
                  BlocBuilder<ProductsCubit, ProductsState>(
                    buildWhen: (prev, curr) => curr is WarehouseChanged,
                    builder: (context, state) {
                      return WarehouseFilterHeader(
                        selectedWarehouseName: context.read<ProductsCubit>().selectedWarehouseName,
                        onWarehouseTap: () => _showWarehouseBottomSheet(context),
                        onSettingsTap: () {
                          Navigator.pushNamed(context, Routes.warehousesManagement);
                        },
                      );
                    },
                  ),

                  ProductsCategoriesTabBar(
                    tabController: _tabController,
                    tabs: _tabs,
                    onTap: (index) {
                      context.read<ProductsCubit>().filterByCategory(_tabs[index]);
                    },
                  ),

                  Expanded(
                    child: BlocBuilder<ProductsCubit, ProductsState>(
                      buildWhen: (prev, curr) => curr is! WarehouseChanged,
                      builder: (context, state) {
                        if (state is ProductsLoading) return const Center(child: CircularProgressIndicator());

                        if (state is ProductsSuccess) {
                          final cubit = context.read<ProductsCubit>();
                          final lowStockAlerts = cubit.lowStockItems;

                          return ListView(
                            padding: EdgeInsets.only(
                                left: 16.w,
                                right: 16.w,
                                top: 0,
                                bottom: 100.h
                            ),
                            physics: const BouncingScrollPhysics(),
                            children: [
                              if (lowStockAlerts.isNotEmpty) ...[
                                SizedBox(height: 12.h),
                                ...lowStockAlerts.map((product) => LowStockAlertCard(
                                  productName: product.name,
                                  remainingQuantity: product.quantity,
                                )),
                              ],
                              SizedBox(height: 16.h),

                              ProductsList(
                                products: state.products,
                                onProductTap: (product) {
                                  Navigator.pushNamed(
                                    context,
                                    Routes.productDetails,
                                    arguments: product.id,
                                  );
                                },
                              ),
                            ],
                          );
                        }

                        if (state is ProductsEmpty) return const EmptyProductsWidget();
                        if (state is ProductsFailure) return Center(child: Text(state.message));
                        return const SizedBox();
                      },
                    ),
                  ),
                ],
              ),
            );
          }
      ),
    );
  }
}