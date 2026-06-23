import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/company_entity.dart';
part 'more_state.dart';

class MoreCubit extends Cubit<MoreState> {
  MoreCubit() : super(MoreInitial());

  void logout() {
    emit(MoreLogoutLoading());
    Future.delayed(const Duration(seconds: 1), () => emit(MoreLogoutSuccess()));
  }
}
