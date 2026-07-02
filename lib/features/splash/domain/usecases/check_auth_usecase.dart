import 'package:shared_preferences/shared_preferences.dart';

class CheckAuthUseCase {
  final SharedPreferences sharedPreferences;

  CheckAuthUseCase(this.sharedPreferences);

  // هيرجع String يحدد اتجاه الشاشة القادمة
  Future<String> call() async {
    final token = sharedPreferences.getString('token');

    if (token != null && token.isNotEmpty) {
      return 'home';
    }

    return 'login';
  }
}