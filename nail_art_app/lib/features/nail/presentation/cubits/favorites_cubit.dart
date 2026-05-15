// lib/features/nail/presentation/cubits/favorites_cubit.dart

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/nail_design.dart';
import '../../domain/usecases/get_favorites.dart';
import '../../domain/usecases/toggle_favorite.dart';
import '../../../../core/usecases/usecase.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final GetFavorites getFavorites; //favorileri listeleme
  final ToggleFavorite toggleFavorite; //favori ekleme çıkarma

  FavoritesCubit({
    required this.getFavorites,
    required this.toggleFavorite,
  }) : super(const FavoritesInitial());

  Future<void> loadFavorites() async { //favorilerdeki tasarımları yükler
    emit(const FavoritesLoading()); //yükleniyor durumu

    final result = await getFavorites(const NoParams());

    result.fold(
      (failure) => emit(FavoritesError(message: failure.message)),
      (designs) => emit(FavoritesLoaded(designs: designs)),
    );
  }

  Future<void> removeFavorite(String id) async { //favorilerden ürün kaldırma.
    final currentState = state;
    if (currentState is! FavoritesLoaded) return;

    final result = await toggleFavorite(
      ToggleFavoriteParams(id: id, isFavorite: false),
    );

    result.fold(
      (failure) => emit(FavoritesError(message: failure.message)),
      (_) {
        final updated =
            currentState.designs.where((d) => d.id != id).toList();
        emit(FavoritesLoaded(designs: updated));
      },
    );
  }
}
