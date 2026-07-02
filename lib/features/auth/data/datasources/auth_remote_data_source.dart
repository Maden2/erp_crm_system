import '../../../../core/api/api_constants.dart';
import '../../../../core/api/api_consumer.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login({
    required String email,
    required String password,
    bool rememberMe = true,
  });

  Future<UserModel> getCurrentUser(); // 💡 الدالة الجديدة

  Future<void> logout();
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

    return UserModel.fromJson(response); // Clean! مفيش كاش هنا خلاص
  }

  @override
  Future<UserModel> getCurrentUser() async {
    // 📥 نداء الـ GET ريكويست، والـ Interceptor هيحط التوكن أوتوماتيك في الهيدر
    final response = await api.get(
      ApiConstants.getCurrentUser,
    );

    return UserModel.fromJson(response);
  }

  @override
  Future<void> logout() async {
    await api.post(ApiConstants.logout);
  }
}