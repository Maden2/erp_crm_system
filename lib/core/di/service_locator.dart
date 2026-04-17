import 'package:get_it/get_it.dart';
import '../../features/auth/data/repositories/mock_auth_repository.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/login_use_case.dart';
import '../../features/auth/presentation/manager/auth_cubit.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  // Repositories
  getIt.registerLazySingleton<AuthRepository>(() => MockAuthRepository());

  // Use Cases
  getIt.registerLazySingleton(() => LoginUseCase(getIt<AuthRepository>()));

  // Cubits
  getIt.registerFactory(() => AuthCubit(getIt<LoginUseCase>()));
}