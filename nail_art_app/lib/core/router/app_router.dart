// lib/core/router/app_router.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/nail/domain/entities/nail_design.dart';
import '../../features/nail/presentation/screens/home_screen.dart';
import '../../features/nail/presentation/screens/detail_screen.dart';
import '../../features/nail/presentation/screens/favorites_screen.dart';

class AppRoutes {
  static const String home = '/'; //anasayfa rotası
  static const String detail = '/detail'; //detay sayfası rotası
  static const String favorites = '/favorites'; //favoriler sayfası rotası
}

final GoRouter appRouter = GoRouter( //uygulama ilk açıldığında hangi rotadan başlayacak.
  initialLocation: AppRoutes.home,
  routes: [
    GoRoute(
      path: AppRoutes.home,
      name: 'home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '${AppRoutes.detail}/:id',
      name: 'detail',
      builder: (context, state) {
        final design = state.extra as NailDesign;
        return DetailScreen(design: design);
      },
    ),
    GoRoute(
      path: AppRoutes.favorites,
      name: 'favorites',
      builder: (context, state) => const FavoritesScreen(),
    ),
  ],
  errorBuilder: (context, state) => Scaffold( //uygulamadaa tanımlanmamış bir rotaya gidilmek istenirse çalışır.
    body: Center(
      child: Text('Sayfa bulunamadı: ${state.error}'),
    ),
  ),
);
