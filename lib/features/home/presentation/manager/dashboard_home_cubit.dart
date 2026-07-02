import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/dashboard_home_entity.dart';
import '../../domain/usecases/get_dashboard_home_use_case.dart';

part 'dashboard_home_state.dart';

class DashboardHomeCubit extends Cubit<DashboardHomeState> {
  final GetDashboardHomeUseCase getDashboardHomeUseCase;

  DashboardHomeCubit(this.getDashboardHomeUseCase) : super(DashboardHomeInitial());

  Future<void> loadDashboardHome({String period = "month"}) async {
    emit(DashboardHomeLoading());

    final result = await getDashboardHomeUseCase(period: period);

    result.fold(
          (failure) => emit(DashboardHomeError(message: failure.message)),
          (data) => emit(DashboardHomeSuccess(dashboardData: data)),
    );
  }
}