import 'package:shared_preferences/shared_preferences.dart';

class CheckAuthUseCase {
  final SharedPreferences sharedPreferences;

  CheckAuthUseCase(this.sharedPreferences);

  Future<String> call() async {

    final isFirstTime = sharedPreferences.getBool('is_first_time') ?? true;

    if (isFirstTime) {
      return 'onboarding';
    }

    final token = sharedPreferences.getString('token');

    if (token != null && token.isNotEmpty) {
      return 'home';
    }

    return 'login';
  }
}