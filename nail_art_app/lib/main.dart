// lib/main.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/di/injection_container.dart' as di;
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/nail/presentation/cubits/favorites_cubit.dart';
import 'features/nail/presentation/cubits/nail_detail_cubit.dart';
import 'features/nail/presentation/cubits/nail_home_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.initDependencies();
  runApp(const NailArtApp());
}

class NailArtApp extends StatelessWidget {
  const NailArtApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NailHomeCubit>(
          create: (_) => di.sl<NailHomeCubit>(),
        ),
        BlocProvider<NailDetailCubit>(
          create: (_) => di.sl<NailDetailCubit>(),
        ),
        BlocProvider<FavoritesCubit>(
          create: (_) => di.sl<FavoritesCubit>(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Nail Art',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        routerConfig: appRouter,
      ),
    );
  }
}
