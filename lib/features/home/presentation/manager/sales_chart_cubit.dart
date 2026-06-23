import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_sales_chart_usecase.dart';
import '../../domain/entities/sales_chart_entity.dart';

part 'sales_chart_state.dart';

class SalesChartCubit extends Cubit<SalesChartState> {
  final GetSalesChartUseCase useCase;

  SalesChartCubit(this.useCase) : super(SalesChartInitial());

  String selectedFilter = "1أ";

  Future<void> getSalesChart({required String filter}) async {
    try {
      selectedFilter = filter;

      emit(SalesChartLoading());

      final data = await useCase(filter: filter);

      emit(SalesChartSuccess(data, selectedFilter));
    } catch (e) {
      emit(SalesChartError(e.toString()));
    }
  }
}
