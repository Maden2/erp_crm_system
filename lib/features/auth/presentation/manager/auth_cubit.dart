import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_current_user_use_case.dart';
import '../../domain/usecases/login_use_case.dart';
import '../../domain/usecases/logout_use_case.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final LogoutUseCase logoutUseCase;

  AuthCubit(
      this.loginUseCase,
      this.getCurrentUserUseCase,
      this.logoutUseCase,
      ) : super(AuthInitial());

  Future<void> emitLoginStates({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    emit(AuthLoading());

    try {
      final result = await loginUseCase(
        email: email.trim(),
        password: password.trim(),
        rememberMe: rememberMe,
      );

      result.fold(
            (failure) => emit(AuthError(failure.message)),
            (user) => emit(AuthSuccess(user)),
      );
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> getProfile() async {
    emit(ProfileLoading());

    try {
      final result = await getCurrentUserUseCase();

      result.fold(
            (failure) => emit(ProfileError(failure.message)),
            (user) => emit(ProfileSuccess(user)),
      );
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> logout() async {
    emit(LogoutLoading());

    try {
      final result = await logoutUseCase();

      result.fold(
            (failure) => emit(LogoutError(failure.message)),
            (_) => emit(LogoutSuccess()),
      );
    } catch (e) {
      emit(LogoutError(e.toString()));
    }
  }
}