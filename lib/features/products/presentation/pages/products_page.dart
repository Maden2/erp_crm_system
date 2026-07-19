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
import '../manager/website_products_cubit.dart';
import '../manager/website_products_state.dart';
import '../manager/website_warehouse_cubit.dart';
import '../manager/website_warehouse_state.dart';
import '../widgets/empty_products_widget.dart';
import '../widgets/warehouse_filter_header.dart';
import '../widgets/products_categories_tab_bar.dart';
import '../widgets/products_list.dart';
import '../widgets/products_search_delegate.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> with TickerProviderStateMixin {
  TabController? _tabController;

  // 🟢 تعريف المتغيرات المفقودة
  String _selectedWarehouseName = "جميع المخازن";
  String? _selectedWarehouseId;

  List<Map<String, String>> _dynamicTabs = [
    {"id": "", "name": "جميع الفئات"}
  ];

  @override
  void dispose() {
    _tabController?.removeListener(_handleTabSelection);
    _tabController?.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    if (_tabController != null && !_tabController!.indexIsChanging) {
      setState(() {});
    }
  }

  void _showFilterBottomSheet(BuildContext rootContext) {
    showModalBottomSheet(
      context: rootContext,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const SizedBox(),
    );
  }

  void _showWarehouseBottomSheet(BuildContext rootContext) {
    showModalBottomSheet(
      context: rootContext,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => BlocProvider.value(
        value: getIt<WebsiteWarehouseCubit>()..fetchWarehouses(),
        child: BlocBuilder<WebsiteWarehouseCubit, WebsiteWarehouseState>(
          builder: (context, state) {
            List<Map<String, dynamic>> items = [
              {"id": null, "name": "جميع المخازن", "icon": Icons.inventory_2_outlined}
            ];

            if (state is WebsiteWarehousesSuccess) {
              for (var warehouse in state.warehouses) {
                items.add({
                  "id": warehouse['Id'],
                  "name": warehouse['Name'],
                  "icon": Icons.inventory_2_outlined
                });
              }
            }

            return CustomBottomSheetSelector(
              title: "اختر المخزون",
              subTitle: "اختر مخزوناً لعرض منتجاته.",
              items: items,
              itemBuilder: (item) => GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  setState(() {
                    _selectedWarehouseName = item['name'];
                    _selectedWarehouseId = item['id'];
                  });

                  rootContext.read<WebsiteProductsCubit>().fetchWebsiteProducts(
                    warehouseId: _selectedWarehouseId,
                  );

                  Navigator.pop(context);
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 12.h),
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Row(
                    children: [
                      Icon(item['icon'], color: const Color(0xFF2DD4BF), size: 20.sp),
                      const Spacer(),
                      Text(item['name'], style: const TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<WebsiteProductsCubit>()..fetchWebsiteProducts(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: AppColors.homeBg,
            appBar: CustomAppBar(
            /*  leading: IconButton(
                icon: const Icon(Icons.tune, color: Colors.white),
                onPressed: () => _showFilterBottomSheet(context),
              ),*/
              title: Text(
                "المنتجات",
                style: TextStyles.font18WhiteBold.copyWith(fontFamily: 'Cairo'),
              ),
             /* actions: [
                IconButton(
                  icon: const Icon(Icons.search, color: Colors.white),
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: ProductsSearchDelegate((query) {
                        context.read<WebsiteProductsCubit>().fetchWebsiteProducts(search: query);
                      }),
                    );
                  },
                ),
                SizedBox(width: 8.w),
              ],*/
            ),
           /* floatingActionButton: AppAddButton(
              title: "إضافة منتج",
              onTap: () {},
            ),*/
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            body: Column(
              children: [
                BlocBuilder<WebsiteProductsCubit, WebsiteProductsState>(
                  builder: (context, state) {
                    return WarehouseFilterHeader(
                      selectedWarehouseName: _selectedWarehouseName, // 🟢 تم الربط
                      onWarehouseTap: () => _showWarehouseBottomSheet(context),
                      onSettingsTap: () => Navigator.pushNamed(context, Routes.warehousesManagement),
                    );
                  },
                ),
                BlocBuilder<WebsiteProductsCubit, WebsiteProductsState>(
                  builder: (context, state) {
                    if (state is WebsiteProductsSuccess) {
                      final List<Map<String, String>> fetchedTabs = [
                        {"id": "", "name": "جميع الفئات"}
                      ];
                      final uniqueCategories = <String>{};
                      for (var item in state.productList.items) {
                        if (item.category.isNotEmpty) uniqueCategories.add(item.category);
                      }
                      for (var categoryName in uniqueCategories) {
                        fetchedTabs.add({"id": categoryName, "name": categoryName});
                      }
                      _dynamicTabs = fetchedTabs;
                      final int currentActiveIndex = _tabController?.index ?? 0;
                      _tabController?.removeListener(_handleTabSelection);
                      _tabController?.dispose();
                      _tabController = TabController(
                        length: _dynamicTabs.length,
                        vsync: this,
                        initialIndex: currentActiveIndex < _dynamicTabs.length ? currentActiveIndex : 0,
                      );
                      _tabController!.addListener(_handleTabSelection);
                    }
                    return ProductsCategoriesTabBar(
                      tabController: _tabController ?? TabController(length: 1, vsync: this),
                      tabs: _dynamicTabs.map((e) => e["name"]!).toList(),
                      onTap: (index) {},
                    );
                  },
                ),
                Expanded(
                  child: BlocBuilder<WebsiteProductsCubit, WebsiteProductsState>(
                    builder: (context, state) {
                      if (state is WebsiteProductsLoading) return const Center(child: CircularProgressIndicator());
                      if (state is WebsiteProductsSuccess) {
                        final int selectedTabIndex = _tabController?.index ?? 0;
                        final String selectedCategoryName = _dynamicTabs[selectedTabIndex]["name"] ?? "جميع الفئات";
                        final items = state.productList.items.where((product) {
                          return selectedCategoryName == "جميع الفئات" || product.category == selectedCategoryName;
                        }).toList();
                        if (items.isEmpty) return const EmptyProductsWidget();
                        return ListView(
                          padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 0, bottom: 100.h),
                          physics: const BouncingScrollPhysics(),
                          children: [
                            SizedBox(height: 16.h),
                            ProductsList(
                              products: items,
                              onProductTap: (product) => Navigator.pushNamed(context, Routes.productDetails, arguments: product.id),
                            ),
                          ],
                        );
                      }
                      if (state is WebsiteProductsError) return Center(child: Text(state.message));
                      return const SizedBox();
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}