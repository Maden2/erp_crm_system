import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_analytics_use_case.dart';
import 'analytics_state.dart';

class AnalyticsCubit extends Cubit<AnalyticsState> {
  final GetAnalyticsUseCase getAnalyticsUseCase;

  AnalyticsCubit(this.getAnalyticsUseCase) : super(AnalyticsInitial());

  Future<void> fetchAnalytics() async {
    emit(AnalyticsLoading());
    final result = await getAnalyticsUseCase();
    result.fold(
      (failure) => emit(AnalyticsError(failure.toString())),
      (analytics) => emit(AnalyticsSuccess(analytics)),
    );
  }
}
