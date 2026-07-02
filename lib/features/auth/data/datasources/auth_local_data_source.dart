import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheToken(String token);
  Future<String?> getToken();
  Future<void> clearCache();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;

  AuthLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<void> cacheToken(String token) async {
    await sharedPreferences.setString('token', token);
  }

  @override
  Future<String?> getToken() async {
    return sharedPreferences.getString('token');
  }

  @override
  Future<void> clearCache() async {
    await sharedPreferences.remove('token');
  }
}