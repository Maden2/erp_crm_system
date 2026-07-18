import 'package:shared_preferences/shared_preferences.dart';

class CacheOnboardingUseCase {
  final SharedPreferences sharedPreferences;

  CacheOnboardingUseCase(this.sharedPreferences);

  Future<bool> call() async {
    // 🟢 حفظ false في الكاش عشان "is_first_time" متبقاش true تاني
    return await sharedPreferences.setBool('is_first_time', false);
  }
}