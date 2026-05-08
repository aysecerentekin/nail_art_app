// lib/core/di/injection_container.dart

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/nail/data/datasources/nail_local_datasource.dart';
import '../../features/nail/data/datasources/nail_remote_datasource.dart';
import '../../features/nail/data/repositories/nail_repository_impl.dart';
import '../../features/nail/domain/repositories/nail_repository.dart';
import '../../features/nail/domain/usecases/get_design_by_id.dart';
import '../../features/nail/domain/usecases/get_favorites.dart';
import '../../features/nail/domain/usecases/get_nail_designs.dart';
import '../../features/nail/domain/usecases/toggle_favorite.dart';
import '../../features/nail/presentation/cubits/favorites_cubit.dart';
import '../../features/nail/presentation/cubits/nail_detail_cubit.dart';
import '../../features/nail/presentation/cubits/nail_home_cubit.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // ─── External ───────────────────────────────────────────────
  final sharedPrefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  // ─── Data Sources ───────────────────────────────────────────
  sl.registerLazySingleton<NailRemoteDataSource>(
    () => NailRemoteDataSourceImpl(),
  );

  sl.registerLazySingleton<NailLocalDataSource>(
    () => NailLocalDataSourceImpl(sharedPreferences: sl()),
  );

  // ─── Repositories ───────────────────────────────────────────
  sl.registerLazySingleton<NailRepository>(
    () => NailRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  // ─── Use Cases ──────────────────────────────────────────────
  sl.registerLazySingleton(() => GetNailDesigns(sl()));
  sl.registerLazySingleton(() => GetDesignById(sl()));
  sl.registerLazySingleton(() => ToggleFavorite(sl()));
  sl.registerLazySingleton(() => GetFavorites(sl()));

  // ─── Cubits ─────────────────────────────────────────────────
  sl.registerFactory(
    () => NailHomeCubit(
      getNailDesigns: sl(),
      toggleFavorite: sl(),
    ),
  );

  sl.registerFactory(
    () => NailDetailCubit(toggleFavorite: sl()),
  );

  sl.registerFactory(
    () => FavoritesCubit(
      getFavorites: sl(),
      toggleFavorite: sl(),
    ),
  );
}
