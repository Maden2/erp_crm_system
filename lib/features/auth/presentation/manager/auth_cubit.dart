import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_state.dart';
import '../../domain/usecases/login_use_case.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;

  AuthCubit(this.loginUseCase) : super(AuthInitial());

  Future<void> emitLoginStates({required String email, required String password}) async {
    emit(AuthLoading());
    final response = await loginUseCase.call(email: email, password: password);

    response.fold(
          (failure) => emit(AuthError(failure.message)),
          (user) => emit(AuthSuccess(user)),
    );
  }
}