import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/company_entity.dart';
part 'more_state.dart';

class MoreCubit extends Cubit<MoreState> {
  MoreCubit() : super(MoreInitial());


}
