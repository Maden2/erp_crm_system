import '../../../../core/api/api_constants.dart';
import '../../../../core/api/api_consumer.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login({
    required String email,
    required String password,
    bool rememberMe = true,
  });

  Future<UserModel> getCurrentUser();

  Future<void> logout();

  // 💡 Forgot Password Methods
  Future<String> requestOtp({required String email});
  Future<String> verifyOtp({required String email, required String otp});

  // 🟢 الخطوة الثالثة لتغيير كلمة المرور بالـ Token
  Future<Map<String, dynamic>> resetPassword({
    required String resetToken,
    required String newPassword,
    required String confirmPassword,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiConsumer api;

  AuthRemoteDataSourceImpl(this.api);

  @override
  Future<UserModel> login({
    required String email,
    required String password,
    bool rememberMe = true,
  }) async {
    final response = await api.post(
      ApiConstants.login,
      data: {
        "email": email,
        "password": password,
        "rememberMe": rememberMe,
      },
    );

    return UserModel.fromJson(response);
  }

  @override
  Future<UserModel> getCurrentUser() async {
    final response = await api.get(
      ApiConstants.getCurrentUser,
    );

    return UserModel.fromJson(response);
  }

  @override
  Future<void> logout() async {
    await api.post(ApiConstants.logout);
  }

  // 💡 Forgot Password Implementation
  @override
  Future<String> requestOtp({required String email}) async {
    final response = await api.post(
      ApiConstants.forgotPasswordRequest,
      data: {"email": email},
    );
    return response['data']['message'];
  }

  @override
  Future<String> verifyOtp({required String email, required String otp}) async {
    final response = await api.post(
      ApiConstants.forgotPasswordVerify,
      data: {"email": email, "otp": otp},
    );
    return response['data']['resetToken'];
  }

  // 🟢 تنفيذ ميثود تغيير كلمة المرور النهائية بالملي
  @override
  Future<Map<String, dynamic>> resetPassword({
    required String resetToken,
    required String newPassword,
    required String confirmPassword,
  }) async {
    final response = await api.post(
      ApiConstants.forgotPasswordReset,
      data: {
        "resetToken": resetToken,
        "newPassword": newPassword,
        "confirmPassword": confirmPassword,
      },
    );
    return response;
  }
}