import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_state.dart';
import '../../domain/usecases/login_use_case.dart';
import '../../domain/entities/user_entity.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;

  AuthCubit(this.loginUseCase) : super(AuthInitial());


  Future<void> emitLoginStates({required String email, required String password}) async {
    emit(AuthLoading());

    final cleanEmail = email.trim();
    final cleanPassword = password.trim();

    if (cleanEmail == "pivot@mail.com" && cleanPassword == "12345678") {
      await Future.delayed(const Duration(seconds: 1));

      final mockUser = UserEntity(
        name: "Maden Elmoatasem",
        email: cleanEmail,
        token: "static_mock_token_12345",
      );

      emit(AuthSuccess(mockUser));
      return;
    }

    emit(AuthError("البريد الإلكتروني أو كلمة المرور غير صحيحة"));
  }}