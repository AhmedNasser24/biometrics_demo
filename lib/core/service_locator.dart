import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/auth/data/datasources/local_auth_service.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/tasks/data/repositories/task_repository_impl.dart';
import '../../features/tasks/domain/repositories/task_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  // Data Sources
  sl.registerLazySingleton(() => LocalAuthService());

  // Repositories
  sl.registerFactory<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerFactory<TaskRepository>(() => TaskRepositoryImpl(sl()));
}
