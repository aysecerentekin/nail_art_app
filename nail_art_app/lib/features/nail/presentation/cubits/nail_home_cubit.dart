// lib/features/nail/presentation/cubits/nail_home_cubit.dart

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/nail_design.dart';
import '../../domain/usecases/get_nail_designs.dart';
import '../../domain/usecases/toggle_favorite.dart';

part 'nail_home_state.dart';

class NailHomeCubit extends Cubit<NailHomeState> {
  final GetNailDesigns getNailDesigns;
  final ToggleFavorite toggleFavorite;

  NailHomeCubit({
    required this.getNailDesigns,
    required this.toggleFavorite,
  }) : super(const NailHomeInitial());

  Future<void> loadDesigns({String category = 'Tümü'}) async {
    emit(const NailHomeLoading());

    final result = await getNailDesigns(
      GetNailDesignsParams(category: category),
    );

    result.fold(
      (failure) => emit(NailHomeError(message: failure.message)),
      (designs) => emit(NailHomeLoaded(
        designs: designs,
        selectedCategory: category,
      )),
    );
  }

  Future<void> filterByCategory(String category) async {
    final currentState = state;
    if (currentState is NailHomeLoaded) {
      emit(NailHomeLoading());
    }
    await loadDesigns(category: category);
  }

  Future<void> onToggleFavorite(String id, bool currentValue) async {
    final currentState = state;
    if (currentState is! NailHomeLoaded) return;

    final newFavoriteValue = !currentValue;

    final result = await toggleFavorite(
      ToggleFavoriteParams(id: id, isFavorite: newFavoriteValue),
    );

    result.fold(
      (failure) {
        // Hata olursa UI'ı etkilememesi için
      },
      (_) {
        //  listede anında güncelle
        final updatedDesigns = currentState.designs.map((d) {
          if (d.id == id) return d.copyWith(isFavorite: newFavoriteValue);
          return d;
        }).toList();

        emit(NailHomeLoaded(
          designs: updatedDesigns,
          selectedCategory: currentState.selectedCategory,
        ));
      },
    );
  }
}
